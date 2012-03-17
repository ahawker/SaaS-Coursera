class MoviesController < ApplicationController
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    @redirect_required = false

    @sort_order = _get_sort_order
    @ratings_hash = _get_selected_ratings

    #force a redirect if we're using session data so we stay RESTful
    if @redirect_required
      puts 'redirect req'
      if !@sort_order.nil? && !@ratings_hash.nil?
        redirect_to movies_path(:sort_order => @sort_order, :ratings => @ratings_hash)
      elsif !@sort_order.nil? && @ratings_hash.nil?
        redirect_to movies_path(:sort_order => @sort_order)
      else
        redirect_to movies_path(:ratings => @ratings_hash)
      end
      return
    end
	
	#Pull keys out of ratings filter hash as values are irrelevant.
    if !@ratings_hash.nil?
      @selected_ratings = @ratings_hash.keys
    end

	#Build up filters hash. Not really necessary as I can't figure out how cut down my ActiveRecord query.
    filters = Hash.new
    if !@selected_ratings.nil?
      filters[:ratings] = @selected_ratings
    end
    if !@sort_order.nil?
      filters[:order] = @sort_order
    end

	#I bet this could be cut down to 3-4 lines if I did more reading on ActiveRecord. :/
    if filters.empty?
      @movies = Movie.all
    else
      if !filters[:order].nil?
        if filters[:ratings].nil?
          @movies = Movie.find(:all, :order => filters[:order])
        else
          @movies = Movie.find(:all, :order => filters[:order], :conditions => { :rating => filters[:ratings] })
        end
      else
        if filters[:ratings].nil?
          @movies = Movie.all
        else
          @movies = Movie.find(:all, :conditions => { :rating => filters[:ratings] })
        end
      end
    end

    #Store our sort order and ratings checkboxes in session data.
    if !@sort_order.nil?
      session[:sort_order] = @sort_order
    end
    if !@ratings_hash.nil?
      session[:ratings] = @ratings_hash
    end

  end

  #Get our sort_order. Use value from params if !nil, otherwise attempt to use session data.
  def _get_sort_order
    if !params[:sort_order].nil?
      return params[:sort_order]    
    end
    if !session[:sort_order].nil?
      @redirect_required = true
      order = session[:sort_order]
      session.delete(:sort_order)
      order
    end
  end

  #Get our selected_ratings. Use value from params if !nil, otherwise attempt to use session data.
  def _get_selected_ratings
    if !params[:ratings].nil?
      return params[:ratings]
    end
    if !session[:ratings].nil?
      @redirect_required = true
      ratings = session[:ratings]
      session.delete(:ratings)
      ratings
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
