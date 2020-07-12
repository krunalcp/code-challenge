require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text @company.city
    assert_text @company.state
  end

  test "Show Company Not Fount" do
    visit company_path(id: @company.id + 200)

    assert_text "Company Not Found"
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
    assert_equal "Ventura", @company.city
    assert_equal "CA", @company.state
  end

  test "Update With Existing Email" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_email", with: @company.email)
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal @company.email, @company.email
  end

  test "Update Without Email" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_email", with: "")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "", @company.email
  end

  test "Update Email Error" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Update Company"
    end

    assert_text "Email Domain should be getmainstreet.com"
  end

  test "Update ZipCode Error case 1" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "2816")
      click_button "Update Company"
    end

    assert_text "Zip code Enter 5 digit ZipCode"
  end

  test "Update ZipCode Error case 2" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "27036")
      click_button "Update Company"
    end

    assert_text "Zip code Enter Valid ZipCode"
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
    assert_equal "Waxhaw", last_company.city
    assert_equal "NC", last_company.state
  end

  test "Create Without Email" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "Company Without Email")
      fill_in("company_zip_code", with: " ")
      fill_in("company_phone", with: "5553335555")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "Company Without Email", last_company.name
  end

  test "Create Email Error" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "Email Domain should be getmainstreet.com"
  end

  test "Create ZipCode Error case 1" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "2817")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Zip code Enter 5 digit ZipCode"
  end

  test "Create ZipCode Error case 2" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "27037")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Zip code Enter Valid ZipCode"
  end

  test "Destroy" do
    visit company_path(@company)

    accept_alert do
      click_link 'Delete'
    end

    visit companies_path
    assert_text "Company Destroy"
    assert_text "Companies"
    assert_text "Wolf Painting"
  end
end
