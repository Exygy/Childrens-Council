/// <reference types="Cypress" />

context("Search", () => {
  beforeEach(() => {
    // This is supposed to prevent Cypress from failing tests on JS errors,
    // but Cypress has a bug that is causing this feature to be broken.
    // See https://github.com/cypress-io/cypress/issues/987 for more details.
    cy.on("uncaught:exception", err => {
      return false
    })
  })

  describe("Searching with the default search criteria values from the search page", () => {
    it("should lead to the results page and show some results", () => {
      cy.visit("http://localhost:3000")

      // Fill out the required "About You" info
      cy.get("input[name='full_name']").type("Test Tester")
      cy.get("#email").type("test@test.com")
      cy.get("#zip-code").type("12345")
      cy.get("#care-reason-1").select("Employment")

      cy.get("label[for='agree']").click()
      cy.get("#searchForm input[type='submit']").click()

      cy.location("pathname").should("eq", "/providers")

      cy.get("result").should("have.length.greaterThan", 1)
    })
  })

  describe("Searching by editing search criteria values on the results page", () => {
    it("should perform a new search and show some results", () => {
      // Open the Filters modal
      cy.contains("Show more filters & edit").click()

      // Enter an address and search
      cy.get("#near-address").type("2601 Mission St")
      cy.get(".filters-modal input[value='Search']").click()

      // A search request should be made
      cy.server()
      cy.route("POST", "/api/providers").as("providersSearchRequest")
      cy.wait(["@providersSearchRequest"])

      // Filters modal should close
      cy.get("body").should("not.have.descendants", ".filters-modal")

      // Multiple results should be displayed
      cy.get("result").should("have.length.greaterThan", 1)
    })
  })

  describe("Searching by name from the search page", () => {
    it("should perform a new search and show some results", () => {
      cy.visit("http://localhost:3000")

      // Click on the name search tab
      cy.contains("Search By Program Name").click()

      // Enter part of the name of the owner's name of Dan Dan Family Child Care
      cy.get('input[placeholder="Enter an owner\'s name or a school name."]').type("dangui")

      // Fill out the required "About You" info
      cy.get("input[name='full_name']").type("Test Tester")
      cy.get("#email").type("test@test.com")
      cy.get("#zip-code").type("12345")
      cy.get("#care-reason-1").select("Employment")

      cy.get("label[for='agree']").click()
      cy.get("#searchForm input[type='submit']").click()

      cy.location("pathname").should("eq", "/providers")

      cy.get("result").should("have.length.greaterThan", 0)
      cy.contains("Dan Dan Family Child Care")
    })
  })
})
