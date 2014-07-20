
feature "Picture uploading" do
  scenario "user can upload a picture" do

    visit "/"
    attach_file('Image', 'spec/frame.png')
    click_button "upload"

    within('#container') do
      image = page.find('img')
      expect(image).to_not be_nil
      expect(image['src']).to eq 'frame.png'
    end
  end

  scenario "user can upload a picture with spaces in the name" do

    visit "/"
    attach_file('Image', 'spec/frame with spaces.png')
    click_button "upload"

    within('#container') do
      image = page.find('img')
      expect(image).to_not be_nil
      expect(image['src']).to eq 'frame_with_spaces.png'
    end
  end
end

