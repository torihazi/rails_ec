# frozen_string_literal: true

class PromotionCodesController < ApplicationController
  before_action :promotion_code?, only: %i[create]

  def create
    @promotion_code = PromotionCode.find_by(code: params[:code])

    if @promotion_code.present?
      session[:promotion_code] = @promotion_code.code
      flash[:success] = '割引コードを登録しました'
    else
      flash[:danger] = '不正な割引コードです'
    end
    redirect_to carts_path
  end

  def destroy
    session.delete(:promotion_code)
    flash[:success] = '削除が成功しました'
    redirect_to carts_path
  end

  private

  def promotion_code?
    return unless session[:promotion_code]

    flash[:danger] = '割引コードはお買い物ごとに1回のみ使用可能です'
    redirect_to request.referer
  end
end
