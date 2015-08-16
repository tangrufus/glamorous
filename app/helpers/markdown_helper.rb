module MarkdownHelper
  def markdownify(content)
    markdownify_pipeline.call(content)[:output].to_s.html_safe
  end

  def markdownify_mentioned_user(content)
    markdownify_pipeline.call(content)[:mentioned_user]
  end

  def markdownify_pipeline
    HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::BootstrapResponsiveImageFilter,
      HTML::Pipeline::EmojiFilter,
      HTML::Pipeline::UsernameFilter,
      HTML::Pipeline::AutolinkFilter,
      HTML::Pipeline::SanitizationFilter
    ], markdownify_pipeline_context
  end

  def markdownify_pipeline_context
    {
      gfm: true,
      asset_root: 'https://a248.e.akamai.net/assets.github.com/images/icons/',
      whitelist: markdownify_pipeline_whitelist,
      username_pattern: User::USERNAME_AT_MENTION_PATTERN
    }
  end

  def markdownify_pipeline_whitelist
    Sanitize::Config.merge(
      HTML::Pipeline::SanitizationFilter::WHITELIST,
      attributes: {
        'img' => HTML::Pipeline::SanitizationFilter::WHITELIST[:attributes]['img'] << 'class'
      }
    )
  end
end
