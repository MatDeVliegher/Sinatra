require 'gossip'

class ApplicationController < Sinatra::Base
  get '/' do
    erb :index,locals: {gossips: Gossip.all}
  end

  get '/gossips/:id/' do

    my_gossip = Gossip.find(params['id'].to_i)
    erb :show, locals: {id: params['id'], author: my_gossip[0], content: my_gossip[1]}

  end

  #Afficher la page pour créer un nouveau gossip
  get '/gossips/new/' do
    erb :new_gossip
  end
  #Récup les informations d'un nouveau gossip pour le créer
  post '/gossips/new/' do
    puts "Ceci est le contenu (hash) entré par l'utilsateur : #{params}"
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end

  #Editer un potins
  get '/gossips/:id/edit/' do

    my_gossip = Gossip.find(params['id'].to_i)
    erb :edit, locals: {id: params['id'], author: my_gossip[0], content: my_gossip[1]}

  end

  post '/gossips/:id/edit/' do
    puts "Ceci est le contenu (hash) entré par l'utilsateur : #{params}"
    Gossip.update(params['id'].to_i,params["gossip_author"],params["gossip_content"])
    redirect '/'
  end



end
