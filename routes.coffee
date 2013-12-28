setup = (app, handlers) ->
    app.get '/api/agencies', (req, res) -> handlers.agency.list req, res
    app.post '/api/agencies', (req, res) -> handlers.agency.save req, res
    app.get '/api/agencies/:id', (req, res) -> handlers.agency.show req, res
#   app.post '/api/profiles', handlers.account.createAccount
#   app.get '/api/profiles/:username', handlers.account.getAccount
#   app.put '/api/profiles/:username', handlers.account.updateAccount
#   app.del '/api/profiles/:username', handlers.account.deleteAccount
#   app.post '/api/lists', handlers.list.createShoppingList
#   app.post '/api/lists/:id', handlers.list.createShoppingList
#   app.put '/api/lists/:id', handlers.list.updateShoppingList
#   app.get '/api/lists/:userId', handlers.list.getShoppingLists
#   app.del '/api/lists/:id', handlers.list.deleteShoppingList

exports.setup = setup
