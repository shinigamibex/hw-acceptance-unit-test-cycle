require 'rails_helper'


RSpec.describe MoviesController, type: :controller do
  include Capybara::DSL
  describe "MoviesController" do
    
    context "Updating Director" do
      before :each do
        Movie.create(title: 'Star Wars', rating: 'PG', release_date: Date.new(1977,5,25))
        @movies = Movie.all
      end

      it "Should be updating a movie" do
        movie = @movies.take
        movie_param = {director: 'George Lucas'}
        put :update, id: movie.id, movie: movie_param
      
        expect(flash[:notice]).to eq("#{movie.title} was successfully updated.")
        expect(response).to redirect_to(movie_path(movie.id ))
        

      end

    end
    
    
    context "Find similar director (Sad part)" do
      before :each do
        Movie.create(title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: Date.new(1977,5,25))
        Movie.create(title: 'Blade Runner', rating: 'PG', director: 'Ridley Scott', release_date: Date.new(1982,6,25))
        Movie.create(title: 'THX-1138', rating: 'R', director: 'George Lucas', release_date: Date.new(1971,3,11))
        Movie.create(title: 'Alien' , rating: 'R', director:'', release_date: Date.new(1971,3,1))
  
        @movies = Movie.all
      end

      it "Should be redirect to the home page with an error when can't find similar movies" do
        movie = @movies.where(title: 'Alien').take
        get :similar_movie , format: movie.id
        assert_redirected_to movies_path
        expect(flash[:warning]).to eq("'#{movie.title}' has no director info")
      end
    end


    
    context "Destroy Movies" do
      before :each do
        Movie.create(title: 'Star Wars', rating: 'PG', director: 'George Lucas', release_date: Date.new(1977,5,25))
        @movies = Movie.all
      end

      it "Should be destroy a movie" do
        movie = @movies.take
        delete :destroy, id: movie.id 
      
        expect(flash[:notice]).to eq("Movie '#{movie.title}' deleted.")
        expect(response).to redirect_to(movies_path)
      end

    end

   
      

  end
 

   
      
end
