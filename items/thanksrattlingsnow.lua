-- Functions to create an UI for selecting a card, from All in Jest
-- Used by Apostle of Wands, thank you Paperback, and Thank you RattlingSnow.
function mugen_apostle_of_wands_collection_UIBox(_pool, rows, args)
  args = args or {}
  args.w_mod = args.w_mod or 1
  args.h_mod = args.h_mod or 1
  args.card_scale = args.card_scale or 1
  local deck_tables = {}
  local pool = SMODS.collection_pool(_pool)

  G.your_collection = {}
  local cards_per_page = 0
  local row_totals = {}
  for j = 1, #rows do
    if cards_per_page >= #pool and args.collapse_single_page then
      rows[j] = nil
    else
      row_totals[j] = cards_per_page
      cards_per_page = cards_per_page + rows[j]
      G.your_collection[j] = CardArea(
        G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
        (args.w_mod * rows[j] + 0.25) * G.CARD_W,
        args.h_mod * G.CARD_H,
        { card_limit = rows[j], type = args.area_type or 'title', highlight_limit = 0, collection = true }
      )
      table.insert(deck_tables,
        {
          n = G.UIT.R,
          config = { align = "cm", padding = 0.07, no_fill = true },
          nodes = {
            { n = G.UIT.O, config = { object = G.your_collection[j] } }
          }
        })
    end
  end

  local options = {}
  for i = 1, math.ceil(#pool / cards_per_page) do
    table.insert(
      options,
      localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#pool / cards_per_page))
    )
  end

  G.FUNCS.busterb_card_collection_page = function(e)
    if not e or not e.cycle_config then return end
    for j = 1, #G.your_collection do
      for i = #G.your_collection[j].cards, 1, -1 do
        local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
        c:remove()
        c = nil
      end
    end
    for j = 1, #rows do
      for i = 1, rows[j] do
        local center = pool[i + row_totals[j] + (cards_per_page * (e.cycle_config.current_option - 1))]
        if not center then break end
        local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w / 2, G.your_collection[j].T.y,
          G.CARD_W * args.card_scale, G.CARD_H * args.card_scale, G.P_CARDS.empty,
          (args.center and G.P_CENTERS[args.center]) or center)
        if args.modify_card then args.modify_card(card, center, i, j) end
        if not args.no_materialize then card:start_materialize(nil, i > 1 or j > 1) end
        G.your_collection[j]:emplace(card)
      end
    end
    INIT_COLLECTION_CARD_ALERTS()
  end

  G.FUNCS.busterb_card_collection_page { cycle_config = { current_option = 1 } }

  local t = create_UIBox_generic_options({
    back_func = (args and args.back_func) or G.ACTIVE_MOD_UI and "openModUI_" .. G.ACTIVE_MOD_UI.id or 'your_collection',
    snap_back = args.snap_back,
    infotip = args.infotip,
    no_back = true,
    contents = {
      { n = G.UIT.R, config = { align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05 }, nodes = deck_tables },
      (not args.hide_single_page or cards_per_page < #pool) and {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          create_option_cycle({
            options = options,
            w = 4.5,
            cycle_shoulders = true,
            opt_callback = 'busterb_card_collection_page',
            current_option = 1,
            colour = G.C.RED,
            no_pips = true,
            focus_args = { snap_to = true, nav = 'wide' }
          })
        }
      } or nil,
    }
  })
  return t
end

G.FUNCS.busterb_select_joker = function(e)
  local c1 = e.config.ref_table

  if c1 and c1.is and type(c1.is) == "function" and c1:is(Card) then
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.1,
      func = function()
        G.SETTINGS.paused = false
        if G.OVERLAY_MENU ~= nil then
          G.OVERLAY_MENU:remove()
          G.OVERLAY_MENU = nil
        end

        SMODS.add_card {
          key = c1.config.center_key,
          area = e.config.data[1]
        }

        return true
      end
    }))
  end
end

function busterb_create_select_card_ui(card, area)
  local t2 = {
    n = G.UIT.ROOT,
    config = {
      ref_table = card,
      minw = 0.6,
      padding = 0.1,
      align = 'bm',
      colour = G.C.GREEN,
      shadow = true,
      r = 0.08,
      minh = 0.3,
      one_press = true,
      button = 'busterb_select_joker',
      data = { area },
      hover = true
    },
    nodes = {
      {
        n = G.UIT.T,
        config = {
          text = "Select",
          colour = G.C.WHITE,
          scale = 0.42
        }
      }
    }
  }

  card.children.select_button = UIBox {
    definition = t2,
    config = {
      align = "bm",
      offset = { x = -0, y = -0.15 },
      major = card,
      bond = 'Weak',
      parent = card
    }
  }
end

---@param card table?
---@param cards_to_flip table?
---@param action function?
---@param sound string?
function busterb_use_consumable_animation(card, cards_to_flip, action, sound)
  -- If it's not a list, make it one
  if cards_to_flip and not cards_to_flip[1] then
    cards_to_flip = { cards_to_flip }
  end

  if card then
    G.E_MANAGER:add_event(Event {
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound(sound or 'tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    })
  end

  if cards_to_flip then
    for i = 1, #cards_to_flip do
      local c = cards_to_flip[i]
      local percent = 1.15 - (i - 0.999) / (#cards_to_flip - 0.998) * 0.3

      G.E_MANAGER:add_event(Event {
        trigger = 'after',
        delay = 0.15,
        func = function()
          c:flip()
          play_sound('card1', percent)
          c:juice_up(0.3, 0.3)
          return true
        end
      })
    end

    delay(0.2)
  end

  G.E_MANAGER:add_event(Event {
    trigger = 'after',
    delay = 0.1,
    func = function()
      if action and type(action) == "function" then
        action()
      end
      return true
    end
  })

  if cards_to_flip then
    for i = 1, #cards_to_flip do
      local c = cards_to_flip[i]
      local percent = 0.85 + (i - 0.999) / (#cards_to_flip - 0.998) * 0.3

      G.E_MANAGER:add_event(Event {
        trigger = 'after',
        delay = 0.15,
        func = function()
          c:flip()
          play_sound('tarot2', percent, 0.6)
          c:juice_up(0.3, 0.3)

          -- Update the sprites of cards
          if c.config and c.config.center then
            c:set_sprites(c.config.center)
          end
          if c.ability then
            c.front_hidden = c:should_hide_front()
          end

          return true
        end
      })
    end
  end

  G.E_MANAGER:add_event(Event {
    trigger = 'after',
    delay = 0.2,
    func = function()
      G.hand:unhighlight_all()
      return true
    end
  })

  if cards_to_flip then
    delay(0.5)
  end
end