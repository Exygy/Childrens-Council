/// <reference types="Cypress" />

context("Providers", () => {
  beforeEach(() => {
    // This is supposed to prevent Cypress from failing tests on JS errors,
    // but Cypress has a bug that is causing this feature to be broken.
    // See https://github.com/cypress-io/cypress/issues/987 for more details.
    cy.on("uncaught:exception", err => {
      return false
    })
  })

  describe("Going directly to a provider page", () => {
    it("should show the page", () => {
      // Go to the provider page for Dan Dan Family Child Care
      cy.visit("http://localhost:3000/providers/105")

      // Check that the center name is shown
      cy.contains("Dan Dan Family Child Care")
    })
  })
})
