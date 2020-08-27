ResultsController = (
  $timeout, $anchorScroll, $auth, $scope,
  CompareService, ResultsService, SearchService
) ->
  $ctrl = @

  $scope.covid19ProvidersOnly = ResultsService.covid19ProvidersOnly
  $scope.filterData = SearchService.filterData





  $scope.weekDaysDropdownSettings =
    showCheckAll: false
    showUncheckAll: false
    scrollableHeight: '350px',
    scrollable: true,
    enableSearch: false,
    buttonDefaultText: 'Weeks'

  weekDaysDropdownOnChangeCallback = () ->
    pluralize = if $scope.weekDaysDropDownSelection.length == 1 then '' else 's'
    text = $scope.weekDaysDropDownSelection.length + ' day' + pluralize + ' selected'
    button = text + '<i class="fa fa-caret-down" aria-hidden="true" style="float: right;font-size: 10px;margin-top: 4px;"></i>'

    ResultsService.parent.children[0].weeklySchedule = $scope.weekDaysDropDownSelection.map (day) ->
      return day.id

    $('.week-days .btn.btn-default.dropdown-toggle').html(button)
    setTimeout () -> 
      $('.week-days .btn.btn-default.dropdown-toggle').html(button)
    , 100


      

  $scope.weekDaysDropDownCallback =
    onInitDone: weekDaysDropdownOnChangeCallback,
    onSelectionChanged: weekDaysDropdownOnChangeCallback
  
  $scope.weekDaysDropDownSelection = ResultsService.parent.children[0].weeklySchedule.map (day) ->
    return { "label": day, "id": day }

  $scope.weekDays = SearchService.filterData.days.map (day) ->
    return { "label": day, "id": day }








  $(document).on 'DOMNodeInserted', (e) ->
    target = $(e.target)
    if !target.hasClass('dropdown-menu-form')
      return

    if target.closest('.select').hasClass('filter-select')
      target.append('<li style="text-align:center;margin-top:15px;"><input type="submit" style="border-radius: 26px;text-shadow: none;border: 2px solid #2794B3;background-color: #FFFFFF;height: 32px;padding: 0.625rem;color: #2794B3;font-family: BentonSans Bold;font-size: 12px;line-height: 12px;text-transform: uppercase;" value="Apply"/></li>')






    


  $scope.financialAssistanceDropdownSettings =
    showCheckAll: false
    showUncheckAll: false
    scrollableHeight: '310px',
    scrollable: true,
    enableSearch: false,

  financialAssistanceDropdownOnChangeCallback = () ->
    # ResultsService.parent.children[0].weeklySchedule = $scope.financialAssistanceDropDownSelection.map (day) ->
    #   return day.id

    $('.financial-assistance .btn.btn-default.dropdown-toggle').html('Financial Assistance')
    setTimeout () -> 
      $('.financial-assistance .btn.btn-default.dropdown-toggle').html('Financial Assistance')
    , 100

  $scope.financialAssistanceDropDownCallback =
    onInitDone: financialAssistanceDropdownOnChangeCallback,
    onSelectionChanged: financialAssistanceDropdownOnChangeCallback
  
  $scope.financialAssistanceDropDownSelection = []
  # $scope.financialAssistanceDropDownSelection = SearchService.filterData.financialAssistance.map (program) ->
  #   return { "label": program.label, "id": program.label }

  $scope.financialAssistanceOptions = SearchService.filterData.financialAssistance.map (program) ->
    return { "label": program.label, "id": program.value }












  $scope.otherScheduleOptionDropdownSettings =
    showCheckAll: false
    showUncheckAll: false
    scrollableHeight: '420px',
    scrollable: true,
    enableSearch: false,

  otherScheduleOptionDropdownOnChangeCallback = () ->
    # ResultsService.parent.children[0].weeklySchedule = $scope.otherScheduleOptionDropDownSelection.map (day) ->
    #   return day.id

    $('.other-schedule .btn.btn-default.dropdown-toggle').html('Other Schedule Options')
    setTimeout () -> 
      $('.other-schedule .btn.btn-default.dropdown-toggle').html('Other Schedule Options')
    , 100

  $scope.otherScheduleOptionDropDownCallback =
    onInitDone: otherScheduleOptionDropdownOnChangeCallback,
    onSelectionChanged: otherScheduleOptionDropdownOnChangeCallback
  
  $scope.otherScheduleOptionDropDownSelection = []
  # $scope.otherScheduleOptionDropDownSelection = SearchService.filterData.otherScheduleOption.map (program) ->
  #   return { "label": program.label, "id": program.label }

  $scope.otherScheduleOptionOptions = SearchService.filterData.shiftFeatures.map (shift) ->
    return { "label": shift.name, "id": shift.name }

















  $scope.preschoolProgramDropdownSettings =
    showCheckAll: false
    showUncheckAll: false
    scrollableHeight: '130px',
    scrollable: true,
    enableSearch: false,

  preschoolProgramDropdownOnChangeCallback = () ->
    ResultsService.filters.preschoolProgram = $scope.preschoolProgramDropDownSelection.length > 0

    $('.preschool-program .btn.btn-default.dropdown-toggle').html('Preschool Programs')
    setTimeout () -> 
      $('.preschool-program .btn.btn-default.dropdown-toggle').html('Preschool Programs')
    , 100

  $scope.preschoolProgramDropDownCallback =
    onInitDone: preschoolProgramDropdownOnChangeCallback,
    onSelectionChanged: preschoolProgramDropdownOnChangeCallback
  
  $scope.preschoolProgramDropDownSelection = if ResultsService.filters.preschoolProgram then [{ "label": 'Preschool Program', "id": 'Preschool Program' }] else []
  $scope.preschoolProgramOptions = [{ "label": 'Preschool Program', "id": 'Preschool Program' }]













  validateForm = () ->
    for field_name, field_obj of $scope.searchForm
      $scope.searchForm[field_name].$setDirty() if field_name[0] != '$'

  $scope.submitSearch = ->
    validateForm()
    if $scope.searchForm.$valid
      SearchService.postSearch()
    return








  $ctrl.$onInit = ->
    $ctrl.parent = $auth.currentUser()
    $ctrl.parentFilter = ResultsService.parent
    $ctrl.providerIdsToCompare = CompareService.data.providerIds
    $ctrl.data = ResultsService.searchResultsData
    $ctrl.filters = ResultsService.filters
    $ctrl.settings = ResultsService.searchSettings
    $ctrl.showMap = false
    SearchService.postSearch() if !$ctrl.data && $ctrl.parent

  $ctrl.postSearch = () ->
    SearchService.postSearch()
    $anchorScroll('search-results-wrapper')

  $ctrl.isCriteriaSearch = () ->
    $ctrl.settings.searchType == 'criteria'

  $scope.$on 'search-service:updated', (event, service) ->
    service.postSearch()

  $timeout $anchorScroll('search-results-wrapper')

  $scope.setLocationType = () ->
    # Reset locations
    ResultsService.filters.addresses = ['']
    ResultsService.filters.zips = ['']
    ResultsService.filters.neighborhoods = ['']

  return $ctrl

ResultsController.$inject = [
  '$timeout', '$anchorScroll', '$auth', '$scope',
  'CompareService', 'ResultsService', 'SearchService'
]

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
