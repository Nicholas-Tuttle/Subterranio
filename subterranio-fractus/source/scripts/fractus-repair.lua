function on_space_platform_arrived_at_fractus(event)
    local old_state = event.old_state
    local platform = event.platform

    if old_state ~= defines.space_platform_state.on_the_path then
        return nil
    end

    if platform.state ~= defines.space_platform_state.no_path and
        platform.state ~= defines.space_platform_state.waiting_for_departure and
        platform.state ~= defines.space_platform_state.waiting_at_station and
        platform.state ~= defines.space_platform_state.paused then
        return nil
    end

    game.print("Launching planetary repair device!")

    local platform_hub = platform.hub
    local hub_inventory = platform_hub.get_inventory(defines.inventory.hub_main)

    -- TODO: Fix for quality!
    if hub_inventory.get_item_count("planetary-repair-device") == 0 then
        game.print("No PRD")
        return nil
    end

    local planetary_repair_device_item, _ = hub_inventory.find_item_stack(
        {"planetary-repair-device", "normal"},
        {"planetary-repair-device", "uncommon"},
        {"planetary-repair-device", "rare"},
        {"planetary-repair-device", "epic"},
        {"planetary-repair-device", "legendary"})

    game.print("PRD found" .. planetary_repair_device_item)

    platform.destroy_asteroid_chunks{}

    platform.eject_item(planetary_repair_device_item, {0, 0}, {0, 10})

    platform.destroy(0)
end