require "application_system_test_case"

class TvsTest < ApplicationSystemTestCase
  setup do
    @tv = tvs(:one)
  end

  test "visiting the index" do
    visit tvs_url
    assert_selector "h1", text: "Tvs"
  end

  test "should create tv" do
    visit tvs_url
    click_on "New tv"

    fill_in "Lien", with: @tv.lien
    fill_in "Name", with: @tv.name
    fill_in "Rss", with: @tv.rss
    click_on "Create Tv"

    assert_text "Tv was successfully created"
    click_on "Back"
  end

  test "should update Tv" do
    visit tv_url(@tv)
    click_on "Edit this tv", match: :first

    fill_in "Lien", with: @tv.lien
    fill_in "Name", with: @tv.name
    fill_in "Rss", with: @tv.rss
    click_on "Update Tv"

    assert_text "Tv was successfully updated"
    click_on "Back"
  end

  test "should destroy Tv" do
    visit tv_url(@tv)
    click_on "Destroy this tv", match: :first

    assert_text "Tv was successfully destroyed"
  end
end
