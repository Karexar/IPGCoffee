require 'rubygems'
require 'nokogiri'
require 'open-uri'
#require 'RMagick'

class AdminsController < ApplicationController
    before_action :set_current_user

    def login
        if @current_user
            redirect_to "/admins/manager"
        end
    end

    def logout
        if @current_user
            session[:user_id] = nil
            @current_user = nil
            redirect_to root_path
        end
    end

    def manager
        if !@current_user
            flash[:error] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            @users = User.all
        end
    end

    def check
      @current_user = Admin.where(name: "admin").first.authenticate(params[:password])
      if @current_user
        session[:user_id] = @current_user.id
        redirect_to "/admins/manager"
      else
        flash[:error] = "Wrong password"
        session[:user_id] = nil
        redirect_to "/admins/login"
      end
    end

    def add_user
        if !@current_user
            flash[:error] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            sciper = params[:old_sciper]
            if sciper == nil
                sciper = flash[:old_sciper]
            end
            url = "https://people.epfl.ch/" + sciper
            file = open(url)
            raw_text = file.read
            page = Nokogiri::HTML(raw_text)
            @name = page.css('head/title')[0].text
            @email = ""
            @sciper = sciper
            match = raw_text.match(/<a href="mailto:(.+)" .*/)
            if match
                @email = match.captures[0]
            end
            match_pic = raw_text.match(/<img src="(https:\/\/people.epfl.ch\/[^"]+)"/)
            if match_pic
                @path_pic = match_pic.captures[0]
            end
            if @name == " " or match == nil
                flash[:error_search] = "Not found"
                redirect_to "/admins/manager"
            end
        end
    end

    def create_user
        if !@current_user
            flash[:error] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            balance_test = params[:balance] =~ /\A-?\d+([.,]\d[05]?)?\z/
            new_user = User.new name: params[:name], email: params[:email], sciper: params[:sciper], balance: params[:balance]
            if new_user.valid? and balance_test != nil
                new_user.save
                flash[:success] = "The user has been successfully created"
                redirect_to "/admins/manager"
            else
                flash[:error_name] = new_user.errors.messages[:name][0]
                flash[:error_email] = new_user.errors.messages[:email][0]
                flash[:error_sciper] = new_user.errors.messages[:sciper][0]
                if new_user.errors.messages[:balance][0] != nil
                    flash[:error_balance] = new_user.errors.messages[:balance][0]
                elsif balance_test == nil
                    flash[:error_balance] = "Error : balance should be something like 20.0, -23.25..."
                end
                @users = User.all
                render 'manager'
            end
        end
    end

    def delete_user
        if !@current_user
            flash[:error] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            User.find(params[:user_id]).destroy
            redirect_to "/admins/manager"
        end
    end

    def edit_user
        if !@current_user
            flash[:error] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            @user = User.find(params[:user_id])
        end
    end

    def save_user
        if !@current_user
            flash[:error] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            user = User.find(params[:user_id])
            user.name = params[:name]
            user.email = params[:email]
            user.sciper = params[:sciper]

            if user.valid?
                user.save
                flash[:success] = "The user has been successfully edited"
                redirect_to "/admins/manager"
            else
                flash[:error_name] = user.errors.messages[:name][0]
                flash[:error_email] = user.errors.messages[:email][0]
                flash[:error_sciper] = user.errors.messages[:sciper][0]
                redirect_to '/admins/edit_user/' + params[:user_id]
            end
        end
    end

    def add_to_balance
        user = User.find(params[:user_id])
        add_test = params[:add] =~ /\A-?\d+([.,]\d[05]?)?\z/
        if add_test
            add = params[:add]
            add.sub(",", ".")
            add = add.to_f
            user.balance += add
        end

        if user.valid? and add_test != nil
            user.save
            flash[:success] = add.round(2).to_s + " CHf added to user balance"
            redirect_to "/admins/manager"
        else
            if user.errors.messages[:balance][0] != nil
                flash[:error_add] = user.errors.messages[:balance][0]
            elsif add_test == nil
                flash[:error_add] = "Error : value should be something like 20.0, -23.25..."
            end
            redirect_to '/admins/edit_user/' + params[:user_id]
        end
    end

    def save_new_user
        if !@current_user
            flash[:success] = "Forbidden"
            return redirect_to request.referrer || root_path
        else
            balance_test = params[:balance] =~ /\A-?\d+([.,]\d[05]?)?\z/
            user = User.new name: params[:name], email: params[:email], sciper: params[:sciper], balance: params[:balance]
            @path_pic = nil
            if user.valid? and balance_test != nil
                user.save
                # Save image to disk
                if params[:path_pic] != nil
                    IO.copy_stream(open(params[:path_pic]), 'app/assets/images/people/'+user.id.to_s+'.png')
                end
                #image = Magick::Image.read('app/assets/images/people/'+user.id.to_s+'.png').first
                #image.change_geometry!("640x480") { |cols, rows, img|
                #    newimg = img.resize(cols, rows)
                #    newimg.write('app/assets/images/people/'+user.id.to_s+'.png')
                #}
                flash[:success] = "The user has been successfully created"
                redirect_to "/admins/manager"
            else
                flash[:error_name] = user.errors.messages[:name][0]
                flash[:error_email] = user.errors.messages[:email][0]
                flash[:error_sciper] = user.errors.messages[:sciper][0]
                if user.errors.messages[:balance][0] != nil
                    flash[:error_balance] = user.errors.messages[:balance][0]
                elsif balance_test == nil
                    flash[:error_balance] = "Error : balance should be something like 20.0, -23.25..."
                end

                flash[:old_sciper] = params[:old_sciper]
                @name = params[:name]
                @email = params[:email]
                @sciper = params[:sciper]
                @balance = params[:balance]
                @path_pic = params[:path_pic]
                render 'add_user'
            end
        end
    end

    private

    def set_current_user
        if session[:user_id]
            @current_user = Admin.find(session[:user_id])
        end
    end
end
