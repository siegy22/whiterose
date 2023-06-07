class PgpsController < ApplicationController
  def edit
  end

  def update
    key_import = GPGME::Key.import(params[:pub_key])
    if key_import.imports.present?
      current_user.update!(pub_key_uid: key_import.imports.first.fpr, pgp_public_key: params[:pub_key])
      redirect_to root_path, notice: "PGP key added."
    else
      redirect_to edit_pgp_path, alert: "Could not import key."
    end
  end
end
