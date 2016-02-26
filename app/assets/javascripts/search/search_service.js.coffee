SearchService = ($http, DataService) ->
  angular.extend SearchService.prototype, DataService

  @ParentIsValid = ->
    @parent.firstName != '' and @parent.lastName != '' and ( @parent.email != '' or @parent.phone != '' )

  @postSearch = (callback) ->
    # thnk about killing api key cookie here
    @current_page = 1
    @performSearch callback

  @

SearchService.$inject = ['$http', 'DataService']
angular.module('CCR').service('SearchService', SearchService)
