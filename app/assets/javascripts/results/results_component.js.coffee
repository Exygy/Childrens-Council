ResultsController = (
  $timeout, $anchorScroll, $auth, $scope, $document,
  CompareService, ResultsService, SearchService, $location, amplitudejs
) ->
  $ctrl = @

  $scope.covid19ProvidersOnly = ResultsService.covid19ProvidersOnly
  $scope.filterData = SearchService.filterData

  $(document).on 'DOMNodeInserted', (e) ->
    target = $(e.target)
    if !target.hasClass('dropdown-menu-form')
      return

    if target.closest('.select').hasClass('filter-select') && !target.closest('.dropdown-menu').hasClass('filter-select-has-apply-btn')
      className = target.closest('.select').data('apply-button-class')
      target.closest('.dropdown-menu').addClass('filter-select-has-apply-btn')
      target.append('<li style="text-align:center;margin-top:15px;"><input class="'+className+'" type="submit" style="border-radius: 26px;text-shadow: none;border: 2px solid #2794B3;background-color: #FFFFFF;height: 32px;padding: 0.625rem;color: #2794B3;font-family: BentonSans Bold;font-size: 12px;line-height: 12px;text-transform: uppercase;" value="Apply"/></li>')

  $scope.weekDaysDropdownSettings =
    showCheckAll: false
    showUncheckAll: false
    scrollableHeight: '350px',
    scrollable: true,
    enableSearch: false

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

  defaultDropdown = 
    settings:
      showCheckAll: false
      showUncheckAll: false
      scrollable: true,
      enableSearch: false,
      dynamicTitle: false
    translations:
      buttonDefaultText: 'Default'

  defaultDropdown.settings.scrollableHeight = '280px'
  defaultDropdown.translations.buttonDefaultText = 'Financial Assistance'
  $scope.financialAssistanceDropdown = angular.copy(defaultDropdown)

  $scope.financialAssistanceOptions = SearchService.filterData.financialAssistance.map (program) ->
    return { "label": program.label, "id": program.value }


  defaultDropdown.settings.scrollableHeight = '420px'
  defaultDropdown.translations.buttonDefaultText = 'Other Schedule Options'
  $scope.otherScheduleOptionDropdown = angular.copy(defaultDropdown)
  
  $scope.otherScheduleOptionOptions = SearchService.filterData.shiftFeatures.map (shift) ->
    return { "label": shift.name, "id": shift.name }

  defaultDropdown.settings.scrollableHeight = '130px'
  defaultDropdown.translations.buttonDefaultText = 'Preschool Programs'
  $scope.preschoolProgramDropdown = angular.copy(defaultDropdown)

  $scope.preschoolProgramOptions = [{ "label": 'Preschool Program', "id": 'Preschool Program' }]

  $scope.otherScheduleOptionsStatus = { open: false }

  $scope.toggleShowOtherScheduleOptionOptions = () =>
    $scope.otherScheduleOptionsStatus.open = !$scope.otherScheduleOptionsStatus.open

  $document.on 'click', (e) => 
    if $scope.otherScheduleOptionsStatus.open
      target = e.target.parentElement
      parentFound = false

      while angular.isDefined(target) && target != null && !parentFound
        if !!target.className.split && target.className.split(' ').indexOf('multiselect-parent') > -1 && !parentFound
          if target.className.split(' ').indexOf('dropdown-toggle-other-schedule-options') > -1
            parentFound = true
        target = target.parentElement

      if !parentFound
        $scope.otherScheduleOptionsStatus = { open: false }
        $scope.$apply()

  updateFormState = (pristine) ->
    for field_name, field_obj of $scope.refineSearchForm
      if field_name[0] != '$'
        if pristine
          $scope.refineSearchForm[field_name].$setPristine() 
        else
          $scope.refineSearchForm[field_name].$setDirty() 

  $scope.submitSearch = ->
    setTimeout () => 
      $document.click()
    , 10
    updateFormState()
    if $scope.refineSearchForm.$valid
      updateFormState(true)
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

    amplitudejs.logEvent('PAGE_VIEW', { 
      pathname: $location.path()
    })

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
  '$timeout', '$anchorScroll', '$auth', '$scope', '$document',
  'CompareService', 'ResultsService', 'SearchService', '$location', 'amplitudejs'
]

angular
  .module('CCR')
  .component('results', {
    controller: ResultsController
    templateUrl: "results/results.html"
  })
