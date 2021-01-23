require './api'
include API

API.class_eval do
  def boss_chat(id, &blk)
    camera_zoom do |z|
      z.id = id
      z.camera = 'boss'
      z.speed = 1

      sequence do
        instance_eval(&blk)
      end
    end
  end
end

FLAG_STICKY_NOTE = 'seen_sticky_note'
FLAG_CRUMPLED_PAPER = 'seen_crumpled_paper'

def_level do
  hints '_hint' do
    message 'The Boss probably can help me if I talk to him again'

    message 'People usually write down safe questions for their passwords... I should look for that, maybe in a paper or sticky note.'

    message "The Boss' favorite food (pizza) + the Boss' age (52)"
  end

  boss_chat '_intro' do
    simple do |s|
      s.sound_open = 'mumble'
      s.messages = [
        'Oh, there you are!',
        "Welcome to Howard Phillips Advertising Agency, we're so happy to have a new member in our family, yada, yada, you're late on the first day kid, you know that's no good, right?"
      ]
    end

    choose do
      on_choice 'Sorry I missed the bus...' do
        message "Yeah, yeah, yeah, it doesn't matter. Now listen here."
      end

      on_choice 'Sorry, my name is...' do
        message "Yeah, yeah, yeah, it doesn't matter. Now listen here."
      end
    end

    messages [
      "You're our new IT guy. That means your job is to make sure all the tech here is working as it should, right?",
      "Well, guess what kid, you're in for a ride. Because there isn't a single computer in this office working right now!"
    ]

    choice do
      on_choice 'Are they all broken?' do
        play_animation 'boss_angry'
        message "No, no, that's not it!\nThey are all in good condition, but something real strange happened."
      end

      on_choice 'Have you tried turning it off and on again?' do
        play_animation 'boss_angry'
        message "No, no, that's not it!\nThey are all in good condition, but something real strange happened."
      end
    end

    message "Thing is, since the new year, no one seems to remember their passwords anymore! And a locked PC is good for nothing. Damn, we haven't been able to get any work done this week!"

    choice do
      on_choice 'Like a collective amnesia?' do
        message 'Yeah, sure, call it any fancy word you like.'
      end

      on_choice "Must have been a crazy new year's party here at the office." do
        message "Well, must have been. Can't say for sure... I don't remember it..."
      end
    end

    messages [
      "All I care about is that every computer in this office is unlocked by the end of the day, that's your first job.",
      "Oh, and we can't afford to lose any data on those computers, so be careful when you're doing your hacking magic bullshit, alright?"
    ]

    choice do
      on_choice "Well, actually, it would be easier to try to find each person's password." do
        message "Great, then do that! I didn't know I was hiring a psychoanalyst too."
      end

      on_choice "... I'll do my MAGIC" do
        message "Alright, but before you mess anything up around the office, let's test your competence."
      end
    end

    message 'Start by unlocking my computer.'
  end

  boss_chat '_outro' do
    messages [
      'Hey, hey, good job kid!',
      "Now you only have... A dozen computers or so.\nGet out there and do your magic! No fooling around, uh!\nYou have until closing hours, go, go, go!"
    ]

    next_level
  end

  sequence do |s|
    s.id = 'boss'
    s.name = 'Boss'
    s.node = 'Danny'

    sequence do
      camera_zoom do |z|
        z.camera = 'boss'
        z.speed = 1

        sequence do
          message 'Hey, why is it taking so long?'

          choose do
            on_choice 'Nothing.' do |c|
              c.not_if_flag = FLAG_STICKY_NOTE

              message 'Get back to work then!'
            end

            on_choice 'Boss, do you remember anything about your password?' do
              messages [
                'I told you kid, it just disappeared from my mind.',
                'Although I remember something...',
                'I wrote down the password... Well, maybe not the password, but a question or something to make me remember it',
                'Try to find that.'
              ]
            end

            on_choice 'Why do you think people forget their passwords?' do |c|
              c.not_if_flag = FLAG_CRUMPLED_PAPER

              messages [
                "Well, it 's simple.",
                'Take a real shitty year, combine that with a party and some wine.',
                "What's the result of the equation?",
                "I'm surprised I remembered to put my pants on this morning."
              ]
            end

            on_choice "Boss, what's your favorite food?" do |c|
              c.if_flag = FLAG_STICKY_NOTE

              messages [
                "Oh, so you're the toady type, uh? First day and you already want to flatter me with food?",
                "Well, I don't mind that. I really like pizza, any pizza.",
                'Just not with pineapple.'
              ]
            end

            on_choice 'Boss, how old are you?' do |c|
              c.if_flag = FLAG_STICKY_NOTE

              play_animation 'boss_angry'
              message "Hey, that's not something you should be asking your boss on your first day! How rude!"

              choose do
                on_choice "It's for the password." do
                  message "Hmpf. I'm 52. I know I don't look like it, but that's the truth."
                end

                on_choice "Sorry, you're right, I won't ask again." do
                  message 'Get back to work then!'
                end
              end
            end

            on_choice "Boss, why'd print your own dating profile?" do |c|
              c.if_flag = FLAG_CRUMPLED_PAPER

              play_animation 'boss_angry'
              message "Kid... This is your first day, so I'll take it easy on you.\nBut there are certain things you simply DON'T ask your Boss about.\nJust get my freaking computer working!"
            end
          end
        end
      end
    end
  end

  password do |p|
    p.name = "The Boss' computer"
    p.passwords = ['pizza52']
    p.pass_message = 'Welcome DannyDaBoss'
    p.fail_message = "Hmm... that didn't seem right"
    p.node = 'Computer1'
  end

  sticky_note do |s|
    s.name = 'sticky note'
    s.message = "password question\nwhat is your favorite food?\n+\nwhat is your age?"
    s.set_flag = FLAG_STICKY_NOTE
  end

  simple do |s|
    s.name = 'trash can'
    s.message = "The Boss' trash can is mostly full of paper. There's a lot of receipts from a place called \"Domingo's Pizza\"."
    s.sound_open = 'rummage'
  end

  simple do |s|
    s.name = 'pizza flyer'
    s.message = "A flyer from Domingo's Pizza. The phone number and part of the menu are underlined."
  end

  multi_visit do |m|
    m.name = 'crumpled paper'
    m.set_flag = FLAG_CRUMPLED_PAPER

    messages [
      "A crumpled piece of paper. Maybe I should unwrap it.\nOh it's... the boss profile from a dating app. The picture is obviously photoshopped.",
      "Why would someone print their dating profile?\nWell, let's see...",
      "\"Danny Darude Junior, 52. Regional manager at Howard Phillips Advertising Agency.\"\n\"A gentle and caring man looking for my soul mate. Surf 4 life!! Also, my job pays well.\"",
      "Wow that's incredibly lame."
    ]

    messages [
      "\"Danny Darude Junior, 52. Regional manager at Howard Phillips Advertising Agency.\"\n\"A gentle and caring man looking for my soul mate. Surf 4 life!! Also, my job pays well.\"",
      'Yep, still lame.'
    ]
  end

  simple do |s|
    s.name = 'bookshelf'
    s.message = "Most books are about business and administration.\nBut there's one called \"Dating after the 40's\"."
  end

  calendar do |c|
    c.name = 'calendar'
    c.message = '<Nothing on the calendar>'
  end

  simple do |s|
    s.name = 'loads of paper on the desk'
    s.message = "The Boss sure has a lot of work to do it seems.\nHm, most of the papers are blank. Is this just for show?"
    s.node = 'Paper'
  end

  simple do |s|
    s.name = 'employee of the month'
    s.message = "The employee of the month is...\nThe Boss himself?"
  end

  simple do |s|
    s.name = 'picture on the wall'
    s.message = "The Boss surfing in Hawaii. He almost looks cool.\nAlmost."
  end

  simple do |s|
    s.name = 'trophy rack'
    s.message = "A bunch of generic trophies and medals, but there's nothing written in any of them"
  end

  simple do |s|
    s.name = 'coffee mug'
    s.sound_open = 'coffee'
    s.message = "World's best Boss. Sure..."
  end
end
