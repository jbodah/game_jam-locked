require './api'
include API

FLAG_OPENED_BAG_IN_CABINET = 'opened_bag_in_cabinet'
FLAG_STEVE_COMPUTER_UNLOCKED = 'steve_computer_unlocked'
FLAG_COFFEE_MACHINE_INSPECTED = 'coffee_machine_inspected'

def_level do
  hints '_hint' do
    message 'Maybe I should look for sticky notes.'

    message 'Steve can probably help me here, I should talk to him again.'

    message 'What kind of herb do cats like?'
  end

  next_level do |n|
    n.id = "_next_level"
  end

  camera_zoom do |z|
    z.id = "_intro"
    z.camera = "steve"
    z.speed = 1

    sequence do |s|
      s.sound_open = "steve_hey"

      message "What's up dude, you new here?"

      choose do
        on_choice "Yeah, I'm the new IT guy." do
          message "Cool, so you're here to unlock the computers."
        end

        on_choice "Sorry, I'm Timothy from human resources. You're fired by the way." do
          messages [
            "What? Oh, I swear that shit ain't mine, I m-mean I don't even smoke!",
            "Wait... You're just messing with me.\nDude! Not cool, dude.\nDid you at least record it? No? Major bummer.",
            "Name's Steve, I'm the most vital person in this whole agency. Without me, no one can work properly.",
            "And by that I mean I'm the office boy and I bring people coffee.\nBut right now the coffee machine is broken, so I'm just chilling."
          ]
        end
      end
    end
  end

  branch 'Steve' do |b|
    b.flag = FLAG_STEVE_COMPUTER_UNLOCKED

    multi_visit do
      camera_zoom do |z|
        z.id = "_intro"
        z.camera = "steve"
        z.speed = 1

        messages [
          "Yo dude, you're a tech wizard! Thanks to you, the cat videos are back.",
          "Also, if you ever need to search something on the internet, feel free to use this computer."
        ]
      end

      message "Sup bro, just chilling? If you ever need to Goojle something, feel free to use the computer."
    end

    camera_zoom do |z|
      z.id = "_intro"
      z.camera = "steve"
      z.speed = 1

      sequence do
        message 'Sup bro?'

        choose do
          on_choice 'Just chilling.' do
            message 'Yo, nice! Me too.'
          end

          on_choice 'Do you remember the password to the computer here?' do
            messages [
              "Dude, unlike the others, I actually didn't forget anything.\nBecause they never told me any password to begin with! I'm the office boy dude!",
              "A sad marginalized worker. That's why I revolt everyday by pooping during company time.",
              "Plus, the computer here is lacking, most websites are blocked, all you can do is search stuff on Goojle and watch cat videos.\nWhich is not that bad, but I wish I could play something."
            ]
          end

          on_choice "Hey, the coffee machine isn't broken." do |c|
            c.if_flag = FLAG_COFFEE_MACHINE_INSPECTED

            message "No dude, it's a schrodinger coffee machine."

            choose do
              on_choice "Schro-what?" do
                message "You know, the guy who put the cat in a box to maybe die."
              end
              on_choice "I feel a dumb explanation incoming." do
                message "No dude"
              end
            end

            messages [
              "You see, I told everyone the coffee machine was broken, and that I would fix it.\nAnd I did. But nobody came here to check if it was fixed.",
              "So, as of now, for everyone in this office except the two of us, the coffee machine is both broken and fixed, at the same time.\nAnd there's no way to know which one is true!",
            ]

            choose do
              on_choice "There is, actually, they just need to come here and check." do
                message "But until then, I chill."
              end

              on_choice "I'm not sure if this is dumb or genius." do
                message "Thanks, I put a lot of effort into being lazy."
              end
            end
          end

          on_choice "Do you know anything about the weed on the cabinet?" do |c|
            c.if_flag = FLAG_OPENED_BAG_IN_CABINET

            messages [
              "You found my stash bro! I can share if you need, but just please don't tell anyone. That bag used to contain catnip, so I just traded a herb for the other. Perfect hiding spot, right?",
            ]

            choose do
              on_choice "You put weed in the catnip bag? That's dangerous for the cat!" do
                messages [
                  "Yo, da cats be sniffin that sweet kush bro!!!",
                  "I'm sorry, weed is a big part of my personality."
                ]
              end

              on_choice "Yo, da cats be sniffin that sweet kush, am I right?" do
                message "Yo, bro, you bet ya! Pussy gettin high on that djamba!"
              end
            end

            messages [
              "Nah, for real, it's fine. Kira got a bunch of catnip in his office already, no one has touched that bag in like a year.",
              "But anyway, if you ever really need to chill, come to me!"
            ]
          end
        end
      end
    end
  end

  branch "Break room computer" do |b|
    b.flag = FLAG_STEVE_COMPUTER_UNLOCKED

    search_engine

    password do |p|
      p.id = "break_room_computer"
      p.actual_password = 'catnip'
      p.pass_message = 'Welcome HowardPhilipsBreakPC'
      p.fail_message = "Hmm... that didn't seem right"
    end
  end

  sequence 'upper cabinet' do
    messages [
      "There's a funny smell coming from this upper cabinet.",
      "Besides the dust, there are also some cans, a half empty wine bottle, a lost remote control...\nAnd finally, a curious looking small sack with a cat's face on it."
    ]

    choose do
      on_choice "Open it." do
        simple do |s|
          s.set_flag = FLAG_OPENED_BAG_IN_CABINET
          s.message = "There's a bunch of weed inside. Well, that explains the smell."
        end
      end

      on_choice "Don't open it." do
        message "No, dumb player, what do you accomplish by not opening it?"

        choose do
          on_choice "Open it." do
            simple do |s|
              s.set_flag = FLAG_OPENED_BAG_IN_CABINET
              s.message = "There's a bunch of weed inside. Well, that explains the smell."
            end
          end

          on_choice "Don't open it." do
            message "Really? Seriously? Do you know how hard it is to program the game when you do this."

            choose do
              on_choice "Open it." do
                simple do |s|
                  s.set_flag = FLAG_OPENED_BAG_IN_CABINET
                  s.message = "There's a bunch of weed inside. Well, that explains the smell."
                end
              end

              on_choice "Don't open it." do
                message "Please dude, just OPEN THE BAG. This is your last warning"

                choose do
                  on_choice "Open it." do
                    simple do |s|
                      s.set_flag = FLAG_OPENED_BAG_IN_CABINET
                      s.message = "There's a bunch of weed inside. Well, that explains the smell."
                    end
                  end

                  on_choice "Don't open it." do
                    play_animation "burn"
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  sequence 'potted plant with a note' do
    message "There is a sticky note hidden in this plant."
    sticky_note do |s|
      s.message = "SECRET! DON'T READ!\nThe password to computer here is:\nA thing my cats love that you can find in this room.\n~ Kira"
    end
  end

  calendar 'calendar' do |c|
    c.message = 'Every day says "watch cat videos"...'
  end

  simple 'coffee machine' do |s|
    s.set_flag = FLAG_COFFEE_MACHINE_INSPECTED
    s.message = "Just a regular coffee machine. Despite what Steve has said, it seems to be working fine."
  end

  simple 'bookshelf' do |s|
    s.message = "Most of the books here are old or simply weird.\nLooks like the Boss bought the cheapest book he could find to fill this bookshelf."
  end

  simple 'refrigerator' do |s|
    s.message = "Oh yeah, the office refrigerator... The heart and soul of chaos at the workplace."
  end

  simple 'employee of the month picture' do |s|
    s.message = "Hey Boss, nice to see you here."
  end

  simple 'dart board' do |s|
    s.messages = [
      "I used to love darts. Then I took a dart in the knee",
      "Anyway, no clues here."
    ]
  end

  simple 'tv' do |s|
    s.messages = [
      "There's a guy on the news trying to argue that unions are actually bad for workers.",
      "Sure, just like sniffing glue does wonders to your health."
    ]
  end

  simple 'magazines' do |s|
    s.message = 'Magazines from months ago. Nobody bothered to update them.'
  end

  simple 'sofa' do |s|
    s.message = "Ah... Pretty comfy. Doesn't help much though."
  end

  simple 'bottom cabinet' do |s|
    s.message = "Here we have canned food, snack bars, cereals, a rat...\nHoly shit, there's a rat in here!"
  end

  simple 'pizza' do |s|
    s.message = "A large pizza from \"Domingo's\". I guess no one was hungry"
  end

  simple 'water cooler' do |s|
    s.message = "Wouldn't be an office without one, right?"
  end

  sequence 'vending machine' do
    message = "Candy... Soda... Chips...\nWho eats this stuff at work?!"

    choose do
      on_choice "Insert a dollar" do
        choose do |c|
          c.sound_open = "chaching"

          on_choice "Candy" do
            messages [
              "<Nothing happens>",
              "Hey! Where's my dollar?!"
            ]
          end

          on_choice "Soda" do
            message "\"Sorry, out of stock\". Nine dimes and a nickel fall out of the machine."
          end

          on_choice "Chips" do
            message "The machine buzzes and whirls as your bag of chips is released.\nIt starts to fall but gets stuck in the machine"
          end
        end
      end

      on_choice "Leave" do
        close
      end
    end
  end

  simple 'a bunch of junk food' do |s|
    s.message = "Half eaten candy bars and open soda. It's like a frat house."
  end

  simple 'fire extinguisher' do |s|
    s.messages = [
      "At least they try to stay safe",
      "\"Expires May 1, 1997\"",
      "Nevermind..."
    ]
  end

  close 'coffee' do |c|
    c.sound_open = 'coffee'
  end

  close 'soda' do |s|
    s.id = 'soda1'
    s.node = 'Soda1'
    s.sound_open = 'coffee'
  end

  close 'soda' do |s|
    s.id = 'soda2'
    s.node = 'Soda2'
    s.sound_open = 'coffee'
  end
end
