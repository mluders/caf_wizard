require 'test_helper'

class BonAppetitServiceTest < ActiveSupport::TestCase
  def test_fetch_dayparts
    bon_appetit_data = file_fixture('bon_appetit_data.json').read
    stub_request(:get, 'https://legacy.cafebonappetit.com/api/2/menus?cafe=1337').to_return(body: bon_appetit_data)

    expected_dayparts = [
      {
        'label' => 'Breakfast',
        'starttime' => '7:30 AM',
        'endtime' => '8:30 AM',
        'stations' => {
          "home cookin'" => [
            'Breakfast Burrito'
          ]
        }
      },
      {
        'label' => 'Lunch',
        'starttime' => '12:00 PM',
        'endtime' => '1:00 PM',
        'stations' => {
          "home cookin'" => [
            'Honey Sriracha Chicken Wrap',
            'Honey Sriracha Crispy Tofu',
            'Chicken And Pepitas Waldorf Salad'
          ]
        }
      },
      {
        'label' => 'Dinner',
        'starttime' => '5:00 PM',
        'endtime' => '6:00 PM',
        'stations' => {
          "home cookin'" => [
            'Chicken Shawarma',
            'Vegan Chicken Shawarma',
            'Chicken And Pepitas Waldorf Salad'
          ]
        }
      }
    ]
    
    assert_equal expected_dayparts, BonAppetitService.fetch_dayparts(cafe_uid: '1337')
  end
end
