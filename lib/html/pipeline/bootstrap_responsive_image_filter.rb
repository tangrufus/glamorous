module HTML
  class Pipeline
    # This filter adds Bootstrap 'img-responsive' class to image tags
    class BootstrapResponsiveImageFilter < Filter
      def call
        doc.search('img').each do |element|
          # Skip if there's already a class attribute. Not sure how this
          # would happen but we can reconsider it in the future.
          next if element['class']

          element['class'] = 'img-responsive'
        end

        doc
      end
    end
  end
end
