require './api'
include API

FLAG_TALKED_TO_JULIA_ABOUT_ROMERO = "talked_to_julia_about_romero"
FLAG_JULIA_COMPUTER_UNLOCKED = "julia_computer_unlocked"
FLAG_ROMERO_COMPUTER_UNLOCKED = "romero_computer_unlocked"

def_level do
  next_level do |n|
    n.id = "_next_level"
  end

  camera_zoom do |z|
    z.id = '_intro'
    z.camera = 'julia'
    z.speed = 1

    sequence do
      simple do |s|
        s.message = 'Oh, are you the IT guy? I was worried you wouldn’t come.'
        s.sound_open = 'cartoon_voice'
      end

      choose do
        on_choice 'It’s me, the IT hero, to save your day!' do
          message 'Oh no, you sound just like Romero.'
        end

        on_choice 'Yeah, it’s me, nice to meet you.' do
          message 'Nice to meet you too!'
        end
      end

      messages [
        'Well, my name is Julia, I’m the sales representative in this agency.',
        'And that guy over there is Romero... He’s a bit... Unique.',
        'Anyway, I’m so glad you’re here, I have a bunch of work and I really need to use my computer.',
        'Talk to me if you need anything.'
      ]
    end
  end

  branch 'Julia' do |b|
    b.flag = FLAG_JULIA_COMPUTER_UNLOCKED

    multi_visit do
      camera_zoom do |z|
        z.camera = "julia"
        z.speed = 1

        messages [
          "Oh, you’re my hero! Thanks a lot.",
          "Now please, get the hell out of here, I have work to do."
        ]
      end

      message "Julia doesn’t respond, she just keeps typing on the computer."
    end

    camera_zoom do |z|
      z.camera = 'julia'
      z.speed = 1

      sequence do
        message 'Any progress? I really need to send some emails.'

        choice do
          on_choice 'Still nothing' do
            '...'
          end

          on_choice 'Do you remember anything about your password, Julia?'  do
            messages [
              'Not exactly, I remember a few things, but it’s all a bit fuzzy...',
              "My password was a word plus a single number at the end.\nAnd there was something pink involved... Sorry, that’s everything I know."
            ]
          end

          on_choice %(So, you’re Romero’s girlfriend, right?) do |c|
            simple do |s|
              s.set_flag = FLAG_TALKED_TO_JULIA_ABOUT_ROMERO
              s.message = "Oh, that’s a common misconception here, but no I’m not.\nI mean, we used to date, but he didn’t want anything serious."
            end

            choice do
              resp = proc do
                messages [
                "Weird right? Even a bit creepy.\nBut he never did anything to me, so I guess it’s fine.",
                "I just don’t want any drama, we share an office after all.\nPlus, as long as he doesn’t interfere with my work, he can have any platonic obsession he wants.",
                'Soon I’ll be promoted and get the hell out of this damn agency!',
                'Whoops, don’t tell that to the boss.'
                ]
              end
              on_choice 'Then why does he have so many pictures of you?', &resp
              on_choice 'But all he talks about is his love for you!', &resp
            end
          end
        end
      end
    end
  end

  branch 'Romero' do |b|
    b.flag = FLAG_ROMERO_COMPUTER_UNLOCKED

    multi_visit do
      camera_zoom do |z|
        z.camera = "romero"
        z.speed = 1

        message "Finally! You may not have the looks I do, but at least you’re pretty clever.\nNot as much as me, of course, but still pretty clever."
      end

      sequence do
        camera_zoom do |z|
          z.camera = "romero"
          z.speed = 1

          message "Bother my beauty no longer, for I have work to do."
        end

        "Romero is just browsing social media."
      end
    end

    camera_zoom do |z|
      z.camera = 'romero'
      z.speed = 1

      multi_visit do
        sequence do
          messages [
            'Oh mere mortal, struck by such sight you stand in shock, thinking your eyes deceive you.',
            "But fear not! I guarantee you this beautiful face isn’t the one of a demon or incubus.\nJust a public relations specialist.",
            'Romero\'s the name.'
          ]

          choice do
            on_choice "Oh... Alright, I guess. I'm here to unlock your computer." do
              message "Do it quickly, will you? I'm not used to waiting for other people.\nIt’s usually the other way around."
            end

            on_choice "What the fuck are you talking about?" do
              messages [
                "Rude.",
                "Just do your job, tech guy."
              ]
            end
          end
        end

        sequence do
          message "I know I'm irresistible, but you have more to do than just staring at me."

          choice do
            on_choice "I sure have, goodbye." do
              message "Oh, it’s so tiring being beautiful."
            end

            on_choice "Romero, do you remember anything about your password?" do
              messages [
                "Oh, how it hurts!\nTo think that such important information could simply vanish overnight.\nNow I fear that one day I might forget her smile..."
              ]

              choice do
                resp = proc do
                  messages [
                    "It's Julia! I was sure my password was the love of my life. How could it be anything else?\nBut I tried inputting her name over and over again, with no success.",
                    "I even tried \"J5L14\"..."
                  ]
                end

                on_choice "Just get to the point already.", &resp
                on_choice "Sorry, what are you talking about?", &resp
              end
            end

            on_choice "Why do you have so many pictures of Julia on your wall?" do
              messages [
                "Is that not clear enough?\nBecause I love her with every fiber of my body!\nShe's my most precious possession, she’s my guiding light!",
                "She gives hope and strength to face this cruel existence!\nJulia is... the son."
              ]

              choice do
                on_choice "You mean \"the sun\"?" do
                  message "Oh, yeah, yeah, that’s it."
                end

                on_choice "(remain silent)" do
                  message "Yes, be speechless in face of true love!"
                end

                on_choice "Julia told me you two aren’t even dating anymore." do |c|
                  c.if_flag = FLAG_TALKED_TO_JULIA_ABOUT_ROMERO

                  messages [
                    "She what? Damn Julia!",
                    "Ok, you’re the IT guy, I don't need to uphold this facade.\nKid, let me teach you one thing.\nDo you know what really attracts women?",
                    "A man’s romantic and unconditional love...\nFor another woman."
                  ]

                  final = "Now get to work! And don’t tell anyone about our conversation."
                  choice do
                    on_choice "You're a jerk." do
                      messages [
                        "Meh, doesn't seem to bother Julia, so what's the problem?",
                        final
                      ]
                    end

                    on_choice "That’s bullshit, you know that?" do
                      messages [
                        "It is not! I read it in a book.",
                        final
                      ]
                    end

                    on_choice "(remain silent)" do
                      messages [
                        "Judge me all you want, you still need to unlock my computer.",
                        final
                      ]
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  password do |p|
    p.name = "Romero's computer"
    p.actual_password = '0128'
    p.pass_message = 'Welcome SexyGuy123'
    p.fail_message = "Hmm... that didn't seem right"
  end

  calendar do |c|
    c.name = "Romero's calendar"
    c.message = "Two dates are on the calendar\n01/17 - Julia's Bday (a lot of <3 here)\n01/28 - My birthday (a ;) face)"
  end

  sticky_note do |s|
    s.name = 'sticky note'
    s.message = 'Password = Most loved one bday'
  end

  simple do |s|
    s.name = 'contact book'
    s.messages = [
      'A contact book, these are probably the clients Romero talks to.',
      'Hm, some of the female names are underlined.'
    ]
  end

  simple do |s|
    s.name = 'books'
    s.message = 'Several romance books. Most of them look like they were never opened.'
    s.node = 'RomanceBooks'
  end

  simple do |s|
    s.name = 'book'
    s.message = '"The art of seduction in 9 easy steps". There are several bookmarks in this book.'
    s.node = 'DeskBook'
  end

  simple do |s|
    s.name = 'photos on the wall'
    s.message = 'MANY photos of Julia and MANY heart stickers.'
  end

  simple do |s|
    s.name = 'papers on desk'
    s.messages = [
      'Apparently Romero waa trying to write poetry... But he really sucks at it!',
      '"Roses are red, Violets are blue, Julia I wanna be, Stuck in you like glue"',
      'So romantic...'
    ]
    s.node = 'Papers'
  end

  simple do |s|
    s.name = 'portrait on desk'
    s.message = "Romero's portrait. His teeth are so white it hurts to look at."
  end

  password do |p|
    p.name = "Julia's computer"
    p.actual_password = 'macbeth7'
    p.pass_message = 'Welcome Juju3'
    p.fail_message = "Hmm... that didn't seem right"
  end

  calendar do |c|
    c.name = "Julia's calendar"
    c.message = "Two dates are on the calendar\n01/16 - My birthday\n01/28 - Romero's birthday"
  end

  simple do |s|
    s.name = 'loads of paper on the desk'
    s.message = "These papers aren't blank like in the Boss's desk. Julia really has a lot to do."
    s.node = 'LoadsOfPaper'
  end

  simple do |s|
    s.name = "Julia's bag"
    s.message = "I may be desperate for clues, but searching through someone's bag is a bit too much."
  end

  simple do |s|
    s.name = "Julia's drawer"
    s.message = 'Lipstick, eyeliner, paper clips and clearly expired vegan sandwich.'
  end

  multi_visit do |m|
    m.name = 'magazine'

    sequence do
      messages [
        'It´s the new year issue of "Mary Shaire", a magazine aimed at young adult women.',
        "There's a numerology chart inside."
      ]

      sticky_note do |n|
        n.message = "(a pop up image, it's a chart that links each zodiac sign to a \"lucky\" number, Capricorn is 7)"
      end
    end

    sequence do
      message "There's a numerology chart inside."
      sticky_note do |n|
        n.message = "(a pop up image, it's a chart that links each zodiac sign to a \"lucky\" number, Capricorn is 7)"
      end
    end
  end

  sequence do |s|
    s.name = 'bookshelf'

    message 'There are several books here, of varying genres.'

    choose do
      on_choice 'Green book...' do
        message "It's \"Macbeth\"."
      end

      on_choice 'Blue book...' do
        message  "It's \"The Catcher in the Rye\"."
      end

      on_choice 'Pink book...' do
        message "It's \"Pride and Prejudice\". There's a note inside the book."

        sticky_note do |s|
          s.message = 'password = green book + lucky number'
        end
      end

      on_choice 'Brown book...' do
        message 'There are several books of this color.'
      end
    end
  end
end
