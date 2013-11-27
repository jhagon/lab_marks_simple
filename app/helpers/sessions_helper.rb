module SessionsHelper

  def sign_in(marker)
    cookies.permanent.signed[:remember_token] = [marker.id, marker.salt]
    current_marker = marker
  end

  def current_marker=(marker)
    @current_marker = marker
  end

  def current_marker
    @current_marker ||= marker_from_remember_token
  end

  def current_marker?(marker)
    marker == current_marker
  end

  def signed_in?
    !current_marker.nil?
  end

  def is_admin?
    signed_in? ? current_marker.admin : false
  end

  def is_admin_and_not_in_user_edit?
    is_admin? && !(request.original_url =~ /edit$/)
  end

  def deny_access
    redirect_to root_url, :alert => "You must be signed in as an administrator to access this page."
  end

  def sign_out
    cookies.delete(:remember_token)
    current_marker = nil
  end

private

  def marker_from_remember_token
    Marker.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil,nil]
  end
end
