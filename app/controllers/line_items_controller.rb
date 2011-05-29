class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.xml
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.xml
  def show
    @line_item = LineItem.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @line_item }
    end
  rescue
    logger.error "Attempt to access invalid line_item: #{params[:id]}"
    redirect_to store_url, :notice => "Error: Line Item #{params[:id]} not found"
  end

  # GET /line_items/new
  # GET /line_items/new.xml
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.xml
  def create
    @cart = current_cart
    @line_item = @cart.add_product(params[:product_id])
    session[:counter] = 0

    respond_to do |format|
      if @line_item.save
        #DEBUG
        logger.debug "*********** LIC#create: format = #{format.inspect}"
        #END DEBUG

        # without javascript button goes here
        # with javascript image link goes here
        format.html { redirect_to('http://www.google.com') }
        # format.html { redirect_to(store_url) }
        # with javascript button goes here
        format.js   { @current_item = @line_item }
        format.xml  { render :xml => @line_item, :status => :created, :location => @line_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      #mp: ~TODO: not really sure this should be a redirect (since this is the page we just left)
      format.html { redirect_to(cart_url(current_cart)) }
      format.xml  { head :ok }
    end
  rescue
    logger.error "Attempt to access delete line_item: #{params[:id]}"
    redirect_to cart_url(current_cart), :notice => "Error: Line Item #{params[:id]} not found"    
  end
end
