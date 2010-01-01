# Controller for handling managing roles.
#
# Author::      Eli Fox-Epstein, efoxepstein@wesleyan.edu
# Author::      Dimitar Gochev, dimitar.gochev@trincoll.edu
# Copyright::   Humanitarian FOSS Project (http://www.hfoss.org), Copyright (C) 2009.
# License::     http://www.gnu.org/copyleft/lesser.html GNU Lesser General Public License (LGPL)

class RolesController < AuthorizedController

  def show
    @role = @instance.roles.find(params[:id])
    return with_rejection unless @current_user.can? :view => @role
  end

  def edit
    @role = @instance.roles.find(params[:id])
    return with_rejection unless @current_user.can? :update => @role
  end

  def index
    @roles = @instance.roles
    return with_rejection unless @current_user.can? :list => @roles
  end

  # Updates an existing role in the database based on the parameters
  # provided in the view, which are stored in the :role hash.
  def update
    @role = @instance.roles.find(params[:id])
    return with_rejection unless @current_user.can? :update => @role
    if @role.update_attributes(params[:role])
      flash[:notice] = t('notice.role_updated')
      redirect_to @role
    else
      #<<FIX: need error msg?
      render :action => 'new'
    end
  end

end

