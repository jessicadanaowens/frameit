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

    #user gets error message if they don't select a file before clicking upload

    click_button "upload"
    expect(page).to have_content("Please select an image to upload")

    #user sees all of their uploaded pictures

    attach_file('Image', 'spec/IMG_6015.png')
    click_button "upload"
    save_and_open_page
    within('#container') do
      image = page.find('img')
      expect(image).to_not be_nil
      expect(image['src']).to eq 'frame.png'
      expect(image['src']).to eq 'IMG_6015.png'
      end
  end
end

