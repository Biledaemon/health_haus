module ApplicationHelper
  def default_meta_tags
    {
      site: 'healthhaus.xyz',
      title: 'HealthHaus',
      reverse: true,
      separator: '|',
      description: 'The simplest way to get health insurance.',
      keywords: 'healthcare, lifestyle, millenials',
      canonical: request.original_url,
      noindex: !Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') }
      ],
      og: {
        site_name: 'healthhaus.xyz',
        title: 'HealthHaus',
        description: 'The simplest way to get health insurance.',
        type: 'website',
        url: request.original_url,
        image: image_url('banner-people.svg')
      }
    }
  end
end
