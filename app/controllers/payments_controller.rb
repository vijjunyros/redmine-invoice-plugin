class PaymentsController < ApplicationController
  unloadable
  layout 'base'
  before_filter :authorize_global, :get_settings

  helper :invoices

  def new
    @payment = Payment.new(params[:payment])
  end
  
  def create
    @payment = Payment.new(params[:payment])
    if @payment.save
      flash[:notice] = "Payment created"
      redirect_to :controller => 'invoice', :action => "show", :id => params[:id], :invoice => { :id => @payment.invoice }
    else
      render :action => 'new', :id => params[:id]
    end    
      
  end
  
  private
  def get_settings
    @settings = Setting.plugin_invoice_plugin
  end
  
end
