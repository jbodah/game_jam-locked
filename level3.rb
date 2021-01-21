require './api'
include API

FLAG_WAITED_ON_NOTEBOOK = "waited_on_notebook"
FLAG_UNLOCKED_MICHELE_COMPUTER = "unlocked_micheles_computer"
FLAG_SPOKE_TO_MICHELE = "spoke_to_michele"
FLAG_UNLOCKED_VINCENT_COMPUTER = "unlocked_vincents_computer"
FLAG_VINCENT_STANDING_AROUND = "vincent_standing_around"

def_level do
  camera_zoom do |c|
    c.camera = "vincent"
    c.id = "_intro"
    c.speed = 1

    sequence do |s|
      message "Ah, a new face! Welcome my boy, to the arts room!\nMy name's Vincent, art director. And that lovely grumpy lady there is Michele. our illustrator."

      choose do
        on_choice "Nice to meet you Vincent, I'm here to unlock the computer." do
          close
        end

        on_choice "Wow, this room is so tacky." do
          message "Hmpf... Sure IT guy, you know all about style, don't you? Anyway."
        end
      end

      message "Suit yourself my dear, if you need anything you can talk to me.\nAnd please, be fast. Gosh it's been ages since I had to rely on pen and paper, so primitive."
    end
  end

  branch "Vincent's computer" do |b|
    b.flag = FLAG_UNLOCKED_VINCENT_COMPUTER

    search_engine

    password do |p|
      p.id = "vincent_s_computer"
      p.actual_password = 'pink9'
      p.pass_message = 'Welcome vitruvian1'
      p.fail_message = "Hmm... that didn't seem right"
    end
  end

  simple 'math table' do |s|
    s.message = "TODO: A mathematical table of the number nine, something like this"
  end

  simple 'flower pot' do |s|
    s.message = 'Vincent takes care of some stunning petunias and roses here.'
  end

  simple 'bookshelf' do |s|
    s.message = 'Art reference books, anatomy studies and... Kinky romance novels.'
  end

  simple 'pictures on the wall' do |s|
    s.message = 'For some reason he framed pictures of geometrical forms....'
  end

  simple 'drawing tablet' do |s|
    s.message = "That's probably how Vincent draws."
  end

  simple 'coffee mug' do |s|
    s.sound_open = 'coffee'
    s.message = "There's actually energy drink inside the mug"
  end

  simple "painting" do |s|
    s.message = "A painting of a naked man T posing. Ok maybe it's not exactly that I guess it has to do with anatomy."
  end

  simple "paint cans" do |s|
    s.sound_open = "coffee"
    s.message = "Uhh... woops"
  end

  branch "Michele's computer" do |b|
    b.flag = FLAG_UNLOCKED_MICHELE_COMPUTER

    search_engine

    password do |p|
      p.id = "michele_s_computer"
      p.actual_password = '16180'
      p.pass_message = 'Welcome BetterThanU'
      p.fail_message = "Hmm... that didn't seem right"
    end
  end

  simple 'bookshelf' do |s|
    s.node = 'Bookshelf2'
    s.message = "Most of the books here are about art, but there are some sci-fi novels too."
  end

  simple 'tea cup' do |s|
    s.sound_open = 'coffee'
    s.message = "It's black tea."
  end

  simple 'pen holder' do |s|
    s.message = "Michele must have more pens and pencils in her desk than everyone else in the office combined."
  end

  simple 'art supplies' do |s|
    s.message = "Weird thing is that her collection of brushes is probably more expensive than a drawing tablet."
  end

  simple "painting" do |s|
    s.node = "Painting2"
    s.message = "A reproduction of a classical painting by a famous artist. It features naked women, angels and a beautiful sunset."
  end

  simple 'ruler' do |s|
    s.message = "Michele's ruler. There's a small red mark on the 1.6 line. I wonder if that means anything..."
  end

  simple 'drawing board' do |s|
    s.message = "This drawing board is probably used by Michele. She's currently drawing a female face... It's stunningly beautiful."
  end

  simple 'manga' do |s|
    s.message = 'A japanese comic book called "Cooper Square Race".'
  end

  sequence 'sketchbook' do
    message = "This is probably Michele's sketchbook. Should I take a look?"

    sketch_book = proc do
      sequence do
        messages [
          "Her drawings are amazing! Most of them are anatomically perfect drawings of women, but there are also a bunch of spiral doodles.",
          "Oh, and there's a note here."
        ]

        green_sticky_note do |s|
          s.message = "Had fun last night, I left a surprise on your computer.\nPS: Your password is so predictable! 5 digits of your special number? Too easy!"
        end
      end
    end

    branch do |b|
      b.flag = FLAG_SPOKE_TO_MICHELE

      sequence(&sketch_book)

      choice do
        on_choice 'Sure.', &sketch_book

        on_choice 'Well, maybe I should ask her first.' do
          simple do |s|
            s.set_flag = FLAG_WAITED_ON_NOTEBOOK
            s.message = "Yeah, better be polite, it's my first day after all."
          end
        end
      end
    end
  end

  camera_zoom 'Vincent' do |z|
    z.camera = 'vincent'
    z.speed = 1

    branch do |b|
      b.flag = FLAG_UNLOCKED_VINCENT_COMPUTER

      multi_visit do
        message "Magnifique! Splendid work darling, splendid!\nNow if you excuse me, I have a real job to resume. Ciao."

        message "Yes, you can watch as my art unfolds on the screen, take a seat and enjoy the show."
      end

      sequence do
        message "Yes?"

        choose do
          on_choice "Just standing around." do |c|
            c.not_if_flag = FLAG_VINCENT_STANDING_AROUND

            sequence do |s|
              s.set_flag = FLAG_VINCENT_STANDING_AROUND

              message "I see, do you also want wine and cheese? Maybe a massage? Must be tired from working so hard."

              choose do
                on_choice "Actually, yeah, a massage would be nice." do
                  message "Vincent doesn't respond, just looks at you dead in the eye."
                end

                on_choice "Say nothing" do
                  message "No? Well then we better get back to work."
                end
              end
            end
          end

          on_choice "Just standing around." do |c|
            c.if_flag = FLAG_VINCENT_STANDING_AROUND

            message "I see, you bask in the calm pleasure of procrastination."
          end

          on_choice "Why does Michele hate you?" do |c|
            c.if_flag = FLAG_SPOKE_TO_MICHELE

            messages [
              "That's a good question, originally I thought she was just jealous of my splendid success and skills.\nBut in the light of recent events, I now understand her better, I even feel pity for the poor creature.",
              "You see, Michele's frustration towards me must be the byproduct of her inability to... Come out."
            ]

            choose do
              on_choice "Come out from where?" do
                message "From the... You know... Closet."

                choose do
                  on_choice "I don't see any closets in here." do
                    message "Ah, just forget it. You have no sense."
                  end
                end

                on_choice "Oh, I understand now." do
                  message "Yes, after all, I'm a vivid and polite person, there's no reason to dislike me.\nBut I can understand her. It's like they say; been there, done that."
                end
              end

              on_choice "Oh, do you think that's it?" do
                message "Most likely. I'm a vivid and polite person, there's no reason to dislike me.\nBut I can understand her. It's like they say; been there, done that."
              end
            end
          end

          on_choice "Why is everything pink?" do
            messages [
              "Why shouldn't it be? Such a beautiful color. It's vivid, makes me happy and gives me energy to endure the hard work of being an art director.",
              "People think it's an easy job, that is just about telling other people what to do. But that's not correct. You have to create, and then, the worst part...",
              "Realize that people didn't properly understand what you told them to do. Oh, so much suffering."
            ]
          end

          on_choice "Why do you have pictures of geometrical shapes?" do
            messages [
              "Because the basic principle of art technique is geometry and mathematics. Many artists don't understand that. Michele and I may disagree on many things, but the reason she's working with me is because she gets that too.",
              "People think that's boring, but it's the magic of art. For example; if we draw any regular polygon inside a circle, the sum of digits of the sum of angles of that polygon always equals 9.",
              "Fascinating, isn't it?"
            ]

            choose do
              on_choice "Wow, amazing!" do
                message "Ah, you get it too! You're smart, dear."
              end

              on_choice "<Make a snoring sound." do
                message "Hm, I seem to be wasting my time."
              end
            end
          end
        end
      end
    end
  end

  camera_zoom 'Michele' do |z|
    z.id = 'michele'
    z.speed = 1

    branch do |b|
      b.flag = FLAG_UNLOCKED_MICHELE_COMPUTER

      multi_visit do
        message "Hey you did it! I know I was rude to you when we met, but... Thanks.\nGuess I don't need to be so defensive after all."
        message "Hey I know I said thanks and all, but don't push it!"
      end

      multi_visit do
        sequence do
          messages [
            "Listen, if you're another one of Vincent's little friends, please don't waste more of my time.",
            "I'm sick enough of having to share the room with that idiot, I don't need another one of his stupid friends bothering my work. So get out!"
          ]

          choose do
            on_choice "Geez! Calm down, I'm just the IT guy." do
              close
            end

            on_choice "Ah... I'm here to unlock your computer." do
              close
            end

            message "Oh... I see, sorry. I didn't mean to be rude but sharing a room with that blockhead puts me on defensive."

            choose do
              on_choice "You and Vincent don't get along very well it seems." do
                message "No, he's a huge moron who thinks he's better than everyone!\nAnd he's not even a great artist, I'm much better, but he's good at licking the boots of the directors and clients. Ack, makes me sick."
              end

              on_choice "Ok, I'll just do my job." do
                message "Well, feel free to talk to me if you need something."
              end
            end
          end
        end

        sequence do
          message "What do you want?"

          choose do
            on_choice "Just checking." do
              message "Please don't distract me for nothing."
            end

            on_choice "Micehele, do you remember anything about your password?" do
              messages [
                "Well, I recall it was... Beautiful!\nI try inputting beautiful names, or other words I like but to no avail.",
                "I also feel there's something important for me to do at my computer today... Dammit, I can't remember anything else."
              ]
            end

            on_choice "Can I take a look at your sketchbook?" do |c|
              c.if_flag = FLAG_WAITED_ON_NOTEBOOK

              message "Hm that's kind of personal, how does that help?"

              choose do
                on_choice "There may be clues inside." do
                  message "Well, I kind of doubt it, but whatever."
                end

                on_choice "It doesn't, I just really liked your art." do
                  message "Oh... Thanks."
                end
              end

              message "Go ahead, you can look. And thanks for asking. Vincent always takes my stuff without asking and that really bothers me! So yeah, glad you asked."
            end

            on_choice "Why are there so many spirals in your office?" do
              message "You mean the Golden Spiral? Well, art has a lot to do with mathematics, and the Golden Spiral is a geometric representation of perfection!\nAre you familiar with the Golden Ratio?"

              choose do
                on_choice "No, what is it?" do
                  messages [
                    "It's a ratio present in many geometrical forms in nature, and since ancient greek artists and mathematicians speculate that it's the foundation for every perfect structure of beauty.",
                    "Represented by the number Phi. The Golden Spiral's growth factor is Phy, and I use it in my works.\nBy the way Phi is 1.61803398875."
                  ]

                  choose do
                    on_choice "Ah ok, thanks, that's helpful." do
                      message "I'm always glad to talk about art."
                    end

                    on_choice "I don't know if that helps, but thanks." do
                      message "I'm always glad to talk about art."
                    end
                  end
                end

                on_choice "Oh no, not a lecture, just get to the point." do
                  message "Then Goojle it asshole!"
                end
              end
            end
          end
        end
      end
    end
  end
end
