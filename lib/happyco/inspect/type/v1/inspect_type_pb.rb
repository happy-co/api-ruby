# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: happyco/inspect/type/v1/inspect_type.proto

require 'google/protobuf'

require 'happyco/type/v1/varia_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "happyco.inspect.type.v1.HeaderField" do
    optional :label, :string, 1
    optional :type, :string, 2
    optional :value, :string, 3
  end
  add_message "happyco.inspect.type.v1.Section" do
    optional :name, :string, 1
    repeated :items, :message, 2, "happyco.inspect.type.v1.Item"
  end
  add_message "happyco.inspect.type.v1.Item" do
    optional :name, :string, 1
    optional :notes, :string, 2
    optional :info, :string, 3
    repeated :photo_urls, :string, 4
    optional :rating_group_key, :string, 5
    map :values, :string, :message, 6, "happyco.inspect.type.v1.RatingValues"
    map :scores, :string, :message, 7, "happyco.type.v1.FloatArray"
  end
  add_message "happyco.inspect.type.v1.FooterField" do
    optional :label, :string, 1
    optional :type, :string, 2
    optional :value, :string, 3
  end
  add_message "happyco.inspect.type.v1.RatingGroups" do
    optional :label, :string, 1
    repeated :ratings, :message, 2, "happyco.inspect.type.v1.RatingControl"
  end
  add_message "happyco.inspect.type.v1.RatingControl" do
    optional :key, :string, 1
    oneof :control_type do
      optional :checkbox, :message, 2, "happyco.inspect.type.v1.RatingCheckbox"
      optional :radio_group, :message, 3, "happyco.inspect.type.v1.RatingRadioGroup"
      optional :drop_down, :message, 4, "happyco.inspect.type.v1.RatingDropDown"
    end
  end
  add_message "happyco.inspect.type.v1.RatingCheckbox" do
    optional :label, :string, 1
    optional :value, :string, 2
    optional :score, :float, 3
    optional :color, :enum, 4, "happyco.inspect.type.v1.RatingColor"
    optional :image, :enum, 5, "happyco.inspect.type.v1.RatingImage"
  end
  add_message "happyco.inspect.type.v1.RatingRadioGroup" do
    optional :label, :string, 1
    repeated :options, :message, 2, "happyco.inspect.type.v1.RatingRadioGroupOption"
  end
  add_message "happyco.inspect.type.v1.RatingRadioGroupOption" do
    optional :value, :string, 2
    optional :score, :float, 3
    optional :color, :enum, 4, "happyco.inspect.type.v1.RatingColor"
    optional :image, :enum, 5, "happyco.inspect.type.v1.RatingImage"
  end
  add_message "happyco.inspect.type.v1.RatingDropDown" do
    optional :label, :string, 1
    repeated :options, :message, 2, "happyco.inspect.type.v1.RatingDropDownOption"
  end
  add_message "happyco.inspect.type.v1.RatingDropDownOption" do
    optional :label, :string, 1
    optional :value, :string, 2
    optional :score, :float, 3
    optional :color, :enum, 4, "happyco.inspect.type.v1.RatingColor"
    optional :image, :enum, 5, "happyco.inspect.type.v1.RatingImage"
  end
  add_message "happyco.inspect.type.v1.RatingValues" do
    oneof :rating_values do
      optional :scalar, :string, 1
      optional :array, :message, 2, "happyco.type.v1.StringArray"
    end
  end
  add_enum "happyco.inspect.type.v1.RatingColor" do
    value :UNKNOWN, 0
    value :RED, 1
    value :ORANGE, 2
    value :YELLOW, 3
    value :GREEN, 4
    value :LIGHT_BLUE, 5
    value :DARK_BLUE, 6
    value :PURPLE, 7
    value :PINK, 8
  end
  add_enum "happyco.inspect.type.v1.RatingImage" do
    value :UNDEFINED, 0
    value :STAR_FULL, 1
    value :STAR_HALF, 2
    value :STAR_EMPTY, 3
    value :TICK_ROUND, 4
    value :CLEAN, 5
    value :SCRATCHES, 6
    value :SPLAT, 7
    value :BROKEN, 8
    value :TICK, 9
    value :CROSS, 10
    value :A, 11
    value :B, 12
    value :C, 13
    value :D, 14
    value :E, 15
    value :F, 16
    value :G, 17
    value :H, 18
    value :I, 19
    value :J, 20
    value :K, 21
    value :L, 22
    value :M, 23
    value :N, 24
    value :O, 25
    value :P, 26
    value :Q, 27
    value :R, 28
    value :S, 29
    value :T, 30
    value :U, 31
    value :V, 32
    value :W, 33
    value :X, 34
    value :Y, 35
    value :Z, 36
    value :DIGIT_0, 37
    value :DIGIT_1, 38
    value :DIGIT_2, 39
    value :DIGIT_3, 40
    value :DIGIT_4, 41
    value :DIGIT_5, 42
    value :DIGIT_6, 43
    value :DIGIT_7, 44
    value :DIGIT_8, 45
    value :DIGIT_9, 46
    value :EXCLAMATION, 47
    value :QUESTION, 48
    value :EXCLAMATION_QUESTION, 49
    value :DOUBLE_EXCLAMATION, 50
    value :DOLLAR, 51
    value :POUND, 52
    value :CENTS, 53
    value :THUMBS_UP, 54
    value :THUMBS_DOWN, 55
    value :AWARD, 56
    value :FEMALE, 57
    value :MALE, 58
    value :CALENDAR, 59
    value :BUILDINGS, 60
    value :BUILDING, 61
    value :HOUSE, 62
    value :NO_ENTRY, 63
    value :DOG, 64
    value :CAT, 65
    value :RAT, 66
    value :CIGARETTE, 67
    value :NO_SMOKING, 68
    value :POOP, 69
    value :WEED, 70
    value :GUN, 71
    value :BROKEN_GLASS, 72
    value :CRACKED, 73
    value :DEAD_FACE, 74
    value :HANDICAP, 75
    value :BROKEN_HEART, 76
    value :HEART, 77
    value :SYRINGE, 78
    value :CLOCK, 79
    value :MUSIC_NOTE, 80
    value :PLANT, 81
    value :NOSE, 82
    value :DROPLET, 83
    value :ELECTRIC, 84
    value :BUG, 85
    value :ARROW_RIGHT, 86
    value :ARROW_LEFT, 87
    value :ARROW_UP, 88
    value :ARROW_DOWN, 89
    value :RECYCLE, 90
    value :TRASH, 91
    value :KEY, 92
    value :LOCK, 93
    value :UNLOCK, 94
    value :CLOUD, 95
    value :SUNSHINE, 96
    value :PLUS, 97
    value :MINUS, 98
    value :TEXTFIELD, 99
    value :METER, 100
    value :CAR, 101
    value :CHART, 102
    value :WRENCH, 103
    value :CALCULATOR, 104
    value :CREDIT_CARD, 105
    value :PAINTBRUSH, 106
    value :ROLLER, 107
    value :MOBILE, 108
    value :FLAG, 109
    value :DOOR_OPEN, 110
    value :DOOR_SHUT, 111
    value :BED, 112
    value :SHOWER, 113
    value :SMOKE_ALARM, 114
    value :LIGHT_BULB, 115
    value :SMILEY_HAPPY, 116
    value :SMILEY_SAD, 117
  end
end

module Happyco
  module Inspect
    module Type
      module V1
        HeaderField = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.HeaderField").msgclass
        Section = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.Section").msgclass
        Item = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.Item").msgclass
        FooterField = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.FooterField").msgclass
        RatingGroups = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingGroups").msgclass
        RatingControl = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingControl").msgclass
        RatingCheckbox = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingCheckbox").msgclass
        RatingRadioGroup = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingRadioGroup").msgclass
        RatingRadioGroupOption = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingRadioGroupOption").msgclass
        RatingDropDown = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingDropDown").msgclass
        RatingDropDownOption = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingDropDownOption").msgclass
        RatingValues = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingValues").msgclass
        RatingColor = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingColor").enummodule
        RatingImage = Google::Protobuf::DescriptorPool.generated_pool.lookup("happyco.inspect.type.v1.RatingImage").enummodule
      end
    end
  end
end
