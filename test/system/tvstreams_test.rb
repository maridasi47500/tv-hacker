require "application_system_test_case"

class TvstreamsTest < ApplicationSystemTestCase
  setup do
    @tvstream = tvstreams(:one)
  end

  test "visiting the index" do
    visit tvstreams_url
    assert_selector "h1", text: "Tvstreams"
  end

  test "should create tvstream" do
    visit tvstreams_url
    click_on "New tvstream"

    fill_in "Firsttv", with: @tvstream.firsttv
    fill_in "Mytv", with: @tvstream.mytv
    fill_in "Name", with: @tvstream.name
    fill_in "Tv", with: @tvstream.tv_id
    click_on "Create Tvstream"

    assert_text "Tvstream was successfully created"
    click_on "Back"
  end

  test "should update Tvstream" do
    visit tvstream_url(@tvstream)
    click_on "Edit this tvstream", match: :first

    fill_in "Firsttv", with: @tvstream.firsttv
    fill_in "Mytv", with: @tvstream.mytv
    fill_in "Name", with: @tvstream.name
    fill_in "Tv", with: @tvstream.tv_id
    click_on "Update Tvstream"

    assert_text "Tvstream was successfully updated"
    click_on "Back"
  end

  test "should destroy Tvstream" do
    visit tvstream_url(@tvstream)
    click_on "Destroy this tvstream", match: :first

    assert_text "Tvstream was successfully destroyed"
  end
end
