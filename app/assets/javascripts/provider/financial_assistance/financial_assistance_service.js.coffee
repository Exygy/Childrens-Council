FinancialAssistanceService =  ->
  @descriptions = {
    'Head Start': 'Early education and preschool programs for families living in San Francisco with children ages 0-5. Eligibility is based on family income and other requirements.',
    'CalWORKs/AP Vouchers': 'This option only applies for families currently receiving CalWORKs benefits. You may select this option to view child care providers that accept vouchers (child care payments from CalWORKs). Keep in mind that some providers may have not notified us that they accept vouchers.',
    'Scholarship': 'Full or partial tuition discount offered by private funding at school site.',
    'Preschool For All': 'Preschool is offered at a reduced cost or free for children aged 4 who reside in San Francisco County. Family income is not required. You can apply directly at sites in the Preschool for All Network.',
    'Q Circle': 'This option only applies to families enrolled in a locally funded voucher program and must choose from the pool of Q-CIRCLE providers/facilities. These providers participate in a city-wide system to improve the quality of care for San Francisco‚Äôs children and families.'
  }

  return @

FinancialAssistanceService.$inject = []

angular
  .module('CCR')
  .service('FinancialAssistanceService', FinancialAssistanceService)
