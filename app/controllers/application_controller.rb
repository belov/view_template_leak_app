class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_for_mobile
  #around_action :log_symbols #log increment symbols
  prepend_view_path 'mobile'

  def log_symbols
    @sym_count_val = Symbol.all_symbols
    yield
    logger.error "Symbols increment: #{(Symbol.all_symbols - @sym_count_val).to_s}; #{controller_name}##{action_name}"
  end



  def prepare_for_mobile
    if mobile_device?
      prepend_view_path "app/views/mobile"
    end

  end


  def mobile_device?
     params[:mobile] == 'true'
  end

end
