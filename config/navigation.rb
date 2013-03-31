# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'active'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
   navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  # navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    primary.item :conference, 'Совещание', conference_url
    primary.item :plan, 'Выполнения плана', plan_url  do |plan|
      plan.dom_class = "nav nav-list"
      plan.item :plan_ешеду, 'Продукты'
      plan.item :plan1, 'Кондитерские(всего)', planshow_url(1)
      plan.item :plan2, 'Карамель(всего)', planshow_url(2)
      plan.item :plan3, 'Карамель(1)', planshow_url(3)
      plan.item :plan4, 'Карам.прогр(2)', planshow_url(4)
      plan.item :plan5, 'Карамель(3)', planshow_url(5)
      plan.item :plan6, 'Карамель(глаз)', planshow_url(6)
      plan.item :plan7, 'Карамель(фас)', planshow_url(7)
      plan.item :plan8, 'Конфеты(всего)', planshow_url(8)
      plan.item :plan9, 'Конфеты(1)', planshow_url(9)
      plan.item :plan10, 'Конфеты(2)', planshow_url(10)
      plan.item :plan11, 'Драже(всего)', planshow_url(11)
      plan.item :plan12, 'Драже вес/фас', planshow_url(12)
      plan.item :plan13, 'Арахис ж/c вес', planshow_url(13)
      plan.item :plan14, 'Арахис ж/с фас', planshow_url(14)
      plan.item :plan15, 'Ирис', planshow_url(15)
      plan.item :plan16, 'Сгущеное молоко', planshow_url(16)
      plan.item :plan17, 'Печенье (всего)', planshow_url(17)
      plan.item :plan18, 'Печенье (вес)', planshow_url(18)
      plan.item :plan19, 'Печенье (глазр)', planshow_url(19)
      plan.item :plan20, 'Печенье (фас)', planshow_url(20)
      plan.item :plan21, 'Глазурь', planshow_url(21)
      plan.item :plan22, 'Брак (прив-карам)', planshow_url(22)
      plan.item :plan23, 'Брак (карам)', planshow_url(23)
      plan.item :plan24, 'Брак (конфет)', planshow_url(24)
    end
    primary.item :implementation, 'Реализация продукции', implementation_url
    primary.item :cash, 'Касса/Вик', cash_url
    primary.item :cashс, 'Касса/Вик-С', cashc_url
    primary.item :balance, 'Расход/оплата ресурсов', balance_url

    # Add an item which has a sub navigation (same params, but with block)
    #primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      #sub_nav.item :key_2_1, 'name', url, options
    #end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    primary.dom_class = 'nav'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
