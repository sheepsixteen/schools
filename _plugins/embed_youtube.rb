require 'uri'

module Kramdown
  module Converter
    class SheepHtml < Html
      def convert_a(el, indent)
        # Get the host of the url
        host = URI(el.attr["href"]).host || ""

        # If the host includes "youtube"
        if host.include? "youtube"
          # Get the video id
          id = URI(el.attr["href"]).query.slice(2..-1)

          # Embed the video
          return %{
            <iframe
              width="100%"
              height="500px"
              class="db center"
              src="https://www.youtube.com/embed/#{id}"
              frameborder="0"
              allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
              allowfullscreen>
            </iframe>
          }
        end

        # Otherwise, just do what Kramdown does normally
        super(el, indent)
      end
    end
  end
end
