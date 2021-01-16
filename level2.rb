require './api'
include API

def_level do
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

  password do |p|
    p.name = "Romero's computer"
    p.actual_password = '0128'
    p.pass_message = 'Welcome SexyGuy123'
    p.fail_message = "Hmm... that didn't seem right"
    p.node = 'Computer1'
  end

  calendar do |c|
    c.name = "Romero's calendar"
    c.message = "Two dates are on the calendar\n01/17 - Julia's Bday (a lot of <3 here)\n01/28 - My birthday (a ;) face)"
    c.node = 'Calendar1'
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
    s.node = 'WallPhoto'
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

    s.node = 'Portrait'
  end

  password do |p|
    p.name = "Julia's computer"
    p.actual_password = 'macbeth7'
    p.pass_message = 'Welcome Juju3'
    p.fail_message = "Hmm... that didn't seem right"
    p.node = 'Computer2'
  end

  calendar do |c|
    c.name = "Julia's calendar"
    c.message = "Two dates are on the calendar\n01/16 - My birthday\n01/28 - Romero's birthday"
    c.node = 'Calendar2'
  end

  simple do |s|
    s.name = 'loads of paper on the desk'
    s.message = "These papers aren't blank like in the Boss's desk. Julia really has a lot to do."
    s.node = 'LoadsOfPaper'
  end

  simple do |s|
    s.name = "Julia's bag"
    s.message = "I may be desperate for clues, but searching through someone's bag is a bit too much."
    s.node = 'Bag'
  end

  simple do |s|
    s.name = "Julia's drawer"
    s.message = 'Lipstick, eyeliner, paper clips and clearly expired vegan sandwich.'
    s.node = 'Drawer'
  end

  multi_visit do |m|
    m.name = 'magazine'

    sequence do
      messages [
        'It´s the new year issue of "Mary Shaire", a magazine aimed at young adult women.',
        "There's a numerology chart inside."
      ]

      sticky_note do |n|
        n.message "(a pop up image, it's a chart that links each zodiac sign to a \"lucky\" number, Capricorn is 7)"
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
    s.node = 'Book'

    message 'There are several books here, of varying genres.'

    choose do
      on_choice 'Green book...' do
        message "It's \"Macbeth\"."
      end

      on_choice 'Blue book...' do
        message  "It's \"The Catcher in the Rye\"."
      end

      on_choice 'Pink book...' do
        sequence do
          message "It's \"Pride and Prejudice\". There's a note inside the book."

          sticky_note do |s|
            s.message = 'password = green book + lucky number'
          end
        end
      end

      on_choice 'Brown book...' do
        message 'There are several books of this color.'
      end
    end
  end
end
