require './api'
include API

FLAG_OPENED_BAG_IN_CABINET = 'opened_bag_in_cabinet'
FLAG_STEVE_COMPUTER_UNLOCKED = 'steve_computer_unlocked'
FLAG_COFFEE_MACHINE_INSPECTED = 'coffee_machine_inspected'

def_level do
  camera_zoom do |z|
    z.id = "_intro"
    z.camera = "steve"
    z.speed = 1

    sequence do
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
      messages [
        "Yo dude, you're a tech wizard! Thanks to you, the cat videos are back.",
        "Also, if you ever need to search something on the internet, feel free to use this computer."
      ]

      message "Sup bro, just chilling? If you ever need to Goojle something, feel free to use the computer."
    end

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

#Interactive objects:
#
#Break room computer -
#Username: HowardPhilipsBreakPC
#Password: catnip
#
#Upper cabinet -
#= There's a funny smell coming from this upper cabinet.
#Besides the dust, there are also some cans, a half empty wine bottle, a lost remote control...
#And finally, a curious looking small sack with a cat's face on it.
#(show sack, if possible)
#Open it.
#There's a bunch of weed inside. Well, that explains the smell.
#Don't open it.
#        No, dumb player, what do you accomlish by not opening it?
#(loop back to the choice)
#
#Potted plant with a note -
#= There is a sticky note hidden in this plant.
#(show note)
#“For safety reasons, I'm going to write this down and hide.
#The password to computer here is:
#A thing my cats love that you can find in this room.
#Kira”
#
#Calendar -
#Exactly like Julia's calendar.
#
#Coffee Machine -
#Just a regular coffee machine. Despite what Steve has said, it seems to be working fine.
#
#Bookshelf -
#= Most of the books here are old or simply weird.
#Looks like the Boss bought the cheapest book he could find to fill this bookshelf.
#
#Refrigerator -
#= Oh yeah, the office refrigerator... The heart and soul of chaos at the workplace.
#
#Employee of the month picture -
#= Hey Boss, nice to see you here.
#
#Dart board -
#= I once hit someone's shoulder with a dart. It's a pretty dangerous game for drunk people.
#Anyway, no clues here.
#
#TV -
#= There's a guy on the news trying to argue that unions are actually bad for workers.
#Sure, just like sniffing glue does wonders to your health.
#
#Magazines -
#= Magazines from months ago. Nobody bothered to update them.
#
#Sofa -
#= Ah... Pretty comfy. Doesn't help much though.
#
#Bottom cabbinet -
#= Here we have canned food, snack bars, cereals, a rat...
#Holy shit, there's a rat in here!
#
#end
