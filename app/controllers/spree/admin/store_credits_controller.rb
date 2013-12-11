module Spree
  class Admin::StoreCreditsController < Admin::ResourceController
    before_filter :check_amounts, :only => [:edit, :update]
    prepend_before_filter :set_remaining_amount, :only => [:create, :update]

    def history
      return if params[:id].nil?
      @user = Spree::User.find(params[:id])
      @user_store_credits = @user.store_credits if @user.has_store_credit?
    end

    private
    def check_amounts
      if (@store_credit.remaining_amount < @store_credit.amount)
        flash[:error] = I18n.t(:cannot_edit_used)
        redirect_to admin_store_credits_path
      end
    end

    def set_remaining_amount
      params[:store_credit][:remaining_amount] = params[:store_credit][:amount]
    end

    def collection
      super.page(params[:page])
    end
  end
end
