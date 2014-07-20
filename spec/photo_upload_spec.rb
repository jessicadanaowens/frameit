feature "Picture uploading" do
  scenario "user can upload a picture" do
    visit "/"

    click_on "Register Now"

    fill_in "Username", :with => "jetaggart"
    fill_in "Password", :with => "password"
    fill_in "Repeat Password", :with => "password"
    click_on "Register/Login"

    attach_file('Image', 'spec/frame.png')
    click_button "upload"

    within('#container') do
      image = page.find('img')
      expect(image).to_not be_nil
      expect(image['src']).to eq 'frame.png'
    end

    #user can upload a picture with spaces in the name

    attach_file('Image', 'spec/frame with spaces.png')
    click_button "upload"

    within('#container') do
      image = page.find('img')
      expect(image).to_not be_nil
      expect(image['src']).to eq 'frame_with_spaces.png'
    end
  end
end

