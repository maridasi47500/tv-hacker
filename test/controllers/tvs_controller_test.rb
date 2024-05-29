require "test_helper"

class TvsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tv = tvs(:one)
  end

  test "should get index" do
    get tvs_url
    assert_response :success
  end

  test "should get new" do
    get new_tv_url
    assert_response :success
  end

  test "should create tv" do
    assert_difference("Tv.count") do
      post tvs_url, params: { tv: { lien: @tv.lien, name: @tv.name, rss: @tv.rss } }
    end

    assert_redirected_to tv_url(Tv.last)
  end

  test "should show tv" do
    get tv_url(@tv)
    assert_response :success
  end

  test "should get edit" do
    get edit_tv_url(@tv)
    assert_response :success
  end

  test "should update tv" do
    patch tv_url(@tv), params: { tv: { lien: @tv.lien, name: @tv.name, rss: @tv.rss } }
    assert_redirected_to tv_url(@tv)
  end

  test "should destroy tv" do
    assert_difference("Tv.count", -1) do
      delete tv_url(@tv)
    end

    assert_redirected_to tvs_url
  end
end
