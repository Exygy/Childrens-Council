describe 'SearchController', ->
  emptyParent =
    firstName: ''
    lastName: ''
    email: ''

  $scope = null
  $state = null
  SearchServiceMock =
    postSearch: ->

  beforeEach module 'CCR'

  beforeEach inject ($rootScope, $controller) ->
    $scope = $rootScope.$new()
    $controller 'SearchController', {
      $scope: $scope,
      $state: $state,
      SearchService: SearchServiceMock
    }

  describe '$scope.parent', ->
    it 'populates scope with empty parent', ->
      expect($scope.parent).toEqual(emptyParent)

  describe '$scope.submitSearch', ->
    it 'submits search to SearchProvider', ->
      spyOn(SearchServiceMock, 'postSearch')
      $scope.submitSearch()
      expect(SearchServiceMock.postSearch).toHaveBeenCalledWith($scope.parent)
