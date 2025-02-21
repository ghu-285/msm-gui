class ActorsController < ApplicationController
  def create
    a = Actor.new
    a.name = params["query_name"]
    a.dob = params["query_dob"]
    a.bio = params["query_bio"]
    a.image = params["query_image"]
    a.save

    redirect_to("/actors")
  end

  def modify
    a = Actor.where({ :id => params["path_id"] }).at(0)
    a.name = params["query_name"]
    a.dob = params["query_dob"]
    a.bio = params["query_bio"]
    a.image = params["query_image"]
    a.save

    redirect_to("/actors/#{params["path_id"]}")
  end

  def delete
    a = Actor.where({ :id => params["path_id"] }).at(0)
    a.destroy
    redirect_to("/actors")
  end

  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
