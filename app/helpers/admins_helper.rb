module AdminsHelper

	def logged_in_admin
		redirect_to new_admin_session_path, notice: "Please login first" unless current_admin
	end
end
