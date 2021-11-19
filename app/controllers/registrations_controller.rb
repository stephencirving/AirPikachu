class RegistrationsController < Devise::RegistrationsController
  protected
  def update_resource(resourse, params)
    resource.update_without_password(params)
  end
end
