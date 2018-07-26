FinancialAssistanceService = ->
  @descriptions = {
    'CalWORKs/AP Vouchers': {
      description: 'This option only applies to families currently receiving CalWORKs benefits. Select this option to view child care programs and preschools that accept vouchers (child care payments from CalWORKs). Please note: some providers who accept vouchers may not have notified us.'
      links: [
        'Apply: <a href="https://www.sfhsa.org/services/jobs-money/calworks" target="_blank">www.sfhsa.org/services/jobs-money/calworks<a>',
      ]
    },
    'Early Learning Scholarship': {
      description: 'This option only applies to families currently receiving an Early Learning Scholarship (ELS) voucher. To receive this benefit, families must live in San Francisco, have children age 0-5 and meet income eligibility guidelines. ',
      links: [
        'View income guidelines: <a href="http://www.childrenscouncil.org/families/help-paying-for-child-care/" target="_blank">www.childrenscouncil.org/families/help-paying-for-child-care/</a>',
        'Apply for an ELS voucher: <a href="https://www.sfcel.org">www.sfcel.org</a>'
      ]
    },
    'Head Start': {
      description: 'Head Start and Early Head Start programs provide free learning and development services to children age 0-5 from low-income families. Eligibility is based on family income and other requirements. ',
      links: [
        'More information: <a href="https://www.acf.hhs.gov/ohs" target="_blank">www.acf.hhs.gov/ohs</a>'
      ]
    },
    'Preschool For All': {
      description: 'Through this program, preschool is offered at a reduced cost or free for children age 4 who reside in San Francisco county. Family income is not required. You can apply directly at child care sites in the Preschool for All Network. ',
      links: [
        'More information: <a href="http://sfoece.org/parents-families/" target="_blank">www.sfoece.org/parents-families/</a>'
      ]
    },
    'Scholarship': {
      description: 'Some child care and preschool sites offer full or partial tuition discounts. Inquire and apply directly at the sites you are interested in.',
    },
    'After School Education and Safety (ASES)': {
      description: '<i>This school participates in ASES.</i> Through this program, after school is offered with an educational enrichment and literacy element and nutritious snacks at no-cost for K-9th grade students. Family income is required. You can apply directly at after school sites.'
    },
    '21st Century Community Learning Centers': {
      description: '<i>This school participates in 21stCentury.</i> Through this program, schools provide academic enrichment opportunities through their after school, before school and summer learning programs for pre-K to 12thgrade. Family income is required. You can apply directly at school sites.',
    },
    'Sibling discount': {
      description: 'A discount is applied to the tuition rate when two or more children from a family are enrolled in the same program. The tuition discount amount varies per program.'
    }
  }

  return @

FinancialAssistanceService.$inject = []

angular
  .module('CCR')
  .service('FinancialAssistanceService', FinancialAssistanceService)
