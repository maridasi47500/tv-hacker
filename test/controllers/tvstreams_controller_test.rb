require "test_helper"

class TvstreamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tvstream = tvstreams(:one)
  end

  test "should get index" do
    get tvstreams_url
    assert_response :success
  end

  test "should get new" do
    get new_tvstream_url
    assert_response :success
  end

  test "should create tvstream" do
    assert_difference("Tvstream.count") do
      post tvstreams_url, params: { tvstream: { firsttv: @tvstream.firsttv, mytv: @tvstream.mytv, name: @tvstream.name, tv_id: @tvstream.tv_id } }
    end

    assert_redirected_to tvstream_url(Tvstream.last)
  end

  test "should show tvstream" do
    get tvstream_url(@tvstream)
    assert_response :success
  end

  test "should get edit" do
    get edit_tvstream_url(@tvstream)
    assert_response :success
  end

  test "should update tvstream" do
    patch tvstream_url(@tvstream), params: { tvstream: { firsttv: @tvstream.firsttv, mytv: @tvstream.mytv, name: @tvstream.name, tv_id: @tvstream.tv_id } }
    assert_redirected_to tvstream_url(@tvstream)
  end

  test "should destroy tvstream" do
    assert_difference("Tvstream.count", -1) do
      delete tvstream_url(@tvstream)
    end

    assert_redirected_to tvstreams_url
  end
end
