script_name("Media List")
script_version("29.11.2024")

local imgui = require 'mimgui'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local json_url = "https://github.com/w99zzl1/MediaList/raw/refs/heads/main/media-list.json"
local prefix = "[Media List]"
local url = "https://github.com/w99zzl1/MediaList/raw/refs/heads/main/media-list.json"

local WinState = imgui.new.bool(false)  -- Состояние окна (по умолчанию оно закрыто)

-- Функция для переключения состояния окна
function toggleWindow()
    WinState[0] = not WinState[0]  -- Переключение состояния окна
end

-- Основной цикл
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    autoupdate("https://github.com/w99zzl1/MediaList/raw/refs/heads/main/media-list.json", '['..string.upper(thisScript().name)..']: ', "https://github.com/w99zzl1/MediaList/raw/refs/heads/main/media-list.json")
    sampRegisterChatCommand('media', toggleWindow)  -- Регистрация команды для открытия окна
    sampAddChatMessage('{FF0000}[Me{FFFFFF}dia]: Используйте {FF0000}/media {FFFFFF}для открытия окна партнёров.', -1)
    while true do
        wait(0)
    end
end

imgui.OnFrame(function()
    return WinState[0] and not isPauseMenuActive()
end, function()
    -- Настройки окна и его размеры
    imgui.SetNextWindowPos(imgui.ImVec2(160, 100), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowSize(imgui.ImVec2(600, 350), imgui.Cond.Always)

    -- Открытие окна и содержимое
    imgui.Begin(u8("Окно-партнёры"), WinState, imgui.WindowFlags.NoResize)
    -- Текст заголовка
    imgui.SetCursorPos(imgui.ImVec2(150, 20))  -- Центрирование текста
    imgui.Text(u8("\nСписок медиа партнёров Advance RP 29/11/2024"))
    imgui.Separator()

    -- Получение размера окна
    local window_size = imgui.GetWindowSize()
    local window_width = window_size.x

    -- Разделение колонок (всего 3 колонки)
    imgui.Columns(3, nil, false)  -- Установка 3 колонок

    -- Настройка ширины каждой колонки
    local column_width = window_width / 3
    imgui.SetColumnWidth(0, column_width)  -- Ширина колонки (ник)
    imgui.SetColumnWidth(1, column_width)  -- Ширина колонки (ссылка)
    imgui.SetColumnWidth(2, column_width)  -- Ширина колонки (сервер)

    -- Заголовки колонок
    imgui.Text(u8("      Ник"))
    imgui.NextColumn()
    imgui.Text(u8("          Ссылка\n   (YouTube/Twitch)"))
    imgui.NextColumn()
    imgui.Text(u8("      Сервер\n(Промокод)"))
    imgui.NextColumn()

    imgui.Separator()

    -- Данные о партнёрах
    local partners = {
        {nick = "   Ken Asakura", link = "https://www.youtube.com/channel/UCA6HC9ecywZTdFrR9DcY07g", server = "Blue\n(OTAR)"},
        {nick = "   Jane Masthead", link = "https://www.twitch.tv/1jxne", server = "Blue\n(JXNE)"},
        {nick = "   Alexey Goldic", link = "https://youtube.com/@goldgoldic?si=h8Uxbxusqkd5m7_Q", server = "Red\n(#goldic)"},
        {nick = "   Soshi Show", link = "https://youtube.com/@soshi1337?si=-qKsOoPS6LCZkKle", server = "Blue\n(#soshi)"},
        {nick = "   Lorenzo Grace", link = "https://youtube.com/@lorenzograce?si=JFT0x7g5EZxXIqr_", server = "Lime\n(GraceLime)"},
        {nick = "   Danches Cuadrado", link = "https://youtube.com/@danchesamp?si=Qdl_F7einuhX_P9n", server = "Blue\n(#Danches)"},
        {nick = "   Cesar Fey", link = "https://youtube.com/@chokosamp?si=NMmzTFKbxBOylZOd", server = "Blue\n(#CHOKO)"},
        {nick = "   Mike Joker", link = "https://youtube.com/@mike_joker?si=iRtppVD2bWlAP3HK", server = "Green\n(joker)"},
        {nick = "   Jordan Riverro", link = "https://youtube.com/@djordi769?si=CTpDzWJNzlNMr6m4", server = "Blue\n(djordi)"},
        {nick = "   Savage Uzi", link = "https://www.youtube.com/@savageuzisamp", server = "Blue\n(UZI)"}
    }

    -- Отображение партнёров
    for _, partner in ipairs(partners) do
        imgui.Text(u8(partner.nick))
        imgui.NextColumn()

        -- Кнопка для перехода по ссылке
        if imgui.Button(u8("Перейти"), imgui.ImVec2(120, 25)) then
            os.execute("start " .. partner.link)
        end
        imgui.NextColumn()

        imgui.Text(u8(partner.server))
        imgui.NextColumn()
    end

    imgui.Columns(1)  -- Завершение колонок
    imgui.Separator()

    if imgui.CollapsingHeader(u8"Выбор стиля", imgui.TreeNodeFlags.DefaultOpen) then
        if imgui.Button(u8"Сбросить стиль", imgui.ImVec2(-1, 0)) then
            apply_classic_blue_style()
        end
        if imgui.Button(u8"Красный стиль", imgui.ImVec2(-1, 0)) then
            apply_red_style()
        end
        if imgui.Button(u8"Оранжевый стиль", imgui.ImVec2(-1, 0)) then
            apply_orange_style()
        end
        if imgui.Button(u8"Жёлтый стиль", imgui.ImVec2(-1, 0)) then
            apply_yellow_style()
        end
        if imgui.Button(u8"Зелёный стиль", imgui.ImVec2(-1, 0)) then
            apply_green_style()
        end
        if imgui.Button(u8"Синий стиль", imgui.ImVec2(-1, 0)) then
            apply_blue_style()
        end
        if imgui.Button(u8"Фиолетовый стиль", imgui.ImVec2(-1, 0)) then
            apply_purple_style()
        end
        if imgui.Button(u8"Белый стиль", imgui.ImVec2(-1, 0)) then
            apply_white_style()
        end
        if imgui.Button(u8"Чёрный стиль", imgui.ImVec2(-1, 0)) then
            apply_black_style()
        end
        if imgui.Button(u8"Коричневый стиль", imgui.ImVec2(-1, 0)) then
            apply_brown_style()
        end
    end

    -- Завершение окна
    imgui.End()  -- Закрытие окна
end)

function reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    for i = 0, 47 do
        colors[i] = ImVec4(0.0, 0.0, 0.0, 0.0)
    end
end


function apply_red_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.8, 0.2, 0.2, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.9, 0.25, 0.25, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.9, 0.25, 0.25, 0.67)
    colors[clr.TitleBg] = ImVec4(0.3, 0.1, 0.1, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.8, 0.2, 0.2, 1.00)
    colors[clr.Button] = ImVec4(0.8, 0.2, 0.2, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.9, 0.25, 0.25, 0.8)
    colors[clr.ButtonActive] = ImVec4(1.0, 0.3, 0.3, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.1, 0.05, 0.05, 0.95)

    colors[clr.Header] = ImVec4(0.8, 0.2, 0.2, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.9, 0.25, 0.25, 0.8)
    colors[clr.HeaderActive] = ImVec4(1.0, 0.3, 0.3, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.8, 0.2, 0.2, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.9, 0.25, 0.25, 0.8)
end

function apply_blue_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.18, 0.49, 0.83, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.18, 0.59, 0.90, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.18, 0.59, 0.90, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.18, 0.49, 0.83, 1.00)
    colors[clr.Button] = ImVec4(0.18, 0.49, 0.83, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.18, 0.59, 0.90, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.18, 0.59, 0.90, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.18, 0.49, 0.83, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.18, 0.59, 0.90, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.18, 0.59, 0.90, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.18, 0.49, 0.83, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.18, 0.59, 0.90, 0.8)
end

function apply_green_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.2, 0.8, 0.2, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.25, 0.85, 0.25, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.25, 0.85, 0.25, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.2, 0.8, 0.2, 1.00)
    colors[clr.Button] = ImVec4(0.2, 0.8, 0.2, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.25, 0.85, 0.25, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.25, 0.85, 0.25, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.2, 0.8, 0.2, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.25, 0.85, 0.25, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.25, 0.85, 0.25, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.2, 0.8, 0.2, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.25, 0.85, 0.25, 0.8)
end

function apply_purple_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.6, 0.2, 0.8, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.7, 0.25, 0.9, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.7, 0.25, 0.9, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.6, 0.2, 0.8, 1.00)
    colors[clr.Button] = ImVec4(0.6, 0.2, 0.8, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.7, 0.25, 0.9, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.7, 0.25, 0.9, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.6, 0.2, 0.8, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.7, 0.25, 0.9, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.7, 0.25, 0.9, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.6, 0.2, 0.8, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.7, 0.25, 0.9, 0.8)
end

function apply_orange_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.8, 0.6, 0.2, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.9, 0.7, 0.25, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.9, 0.7, 0.25, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.8, 0.6, 0.2, 1.00)
    colors[clr.Button] = ImVec4(0.8, 0.6, 0.2, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.9, 0.7, 0.25, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.9, 0.7, 0.25, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.8, 0.6, 0.2, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.9, 0.7, 0.25, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.9, 0.7, 0.25, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.8, 0.6, 0.2, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.9, 0.7, 0.25, 0.8)
end

function apply_white_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(1.0, 1.0, 1.0, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(1.0, 1.0, 1.0, 0.45)
    colors[clr.FrameBgActive] = ImVec4(1.0, 1.0, 1.0, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(1.0, 1.0, 1.0, 1.00)
    colors[clr.Button] = ImVec4(1.0, 1.0, 1.0, 0.6)
    colors[clr.ButtonHovered] = ImVec4(1.0, 1.0, 1.0, 0.8)
    colors[clr.ButtonActive] = ImVec4(1.0, 1.0, 1.0, 1.0)
    colors[clr.Text] = ImVec4(0.0, 0.0, 0.0, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(1.0, 1.0, 1.0, 0.6)
    colors[clr.HeaderHovered] = ImVec4(1.0, 1.0, 1.0, 0.8)
    colors[clr.HeaderActive] = ImVec4(1.0, 1.0, 1.0, 1.0)

    colors[clr.SliderGrab] = ImVec4(1.0, 1.0, 1.0, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(1.0, 1.0, 1.0, 0.8)
end

function apply_black_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.2, 0.2, 0.2, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.3, 0.3, 0.3, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.3, 0.3, 0.3, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.1, 0.1, 0.1, 1.00)
    colors[clr.Button] = ImVec4(0.2, 0.2, 0.2, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.3, 0.3, 0.3, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.3, 0.3, 0.3, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.2, 0.2, 0.2, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.3, 0.3, 0.3, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.3, 0.3, 0.3, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.2, 0.2, 0.2, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.3, 0.3, 0.3, 0.8)
end

function apply_brown_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.55, 0.35, 0.14, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.65, 0.45, 0.24, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.65, 0.45, 0.24, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.55, 0.35, 0.14, 1.00)
    colors[clr.Button] = ImVec4(0.55, 0.35, 0.14, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.65, 0.45, 0.24, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.65, 0.45, 0.24, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.55, 0.35, 0.14, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.65, 0.45, 0.24, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.65, 0.45, 0.24, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.55, 0.35, 0.14, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.65, 0.45, 0.24, 0.8)
end

function apply_yellow_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(1.0, 1.0, 0.0, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(1.0, 1.0, 0.2, 0.45)
    colors[clr.FrameBgActive] = ImVec4(1.0, 1.0, 0.2, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(1.0, 1.0, 0.0, 1.00)
    colors[clr.Button] = ImVec4(1.0, 1.0, 0.0, 0.6)
    colors[clr.ButtonHovered] = ImVec4(1.0, 1.0, 0.2, 0.8)
    colors[clr.ButtonActive] = ImVec4(1.0, 1.0, 0.2, 1.0)
    colors[clr.Text] = ImVec4(0.0, 0.0, 0.0, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(1.0, 1.0, 0.0, 0.6)
    colors[clr.HeaderHovered] = ImVec4(1.0, 1.0, 0.2, 0.8)
    colors[clr.HeaderActive] = ImVec4(1.0, 1.0, 0.2, 1.0)

    colors[clr.SliderGrab] = ImVec4(1.0, 1.0, 0.0, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(1.0, 1.0, 0.2, 0.8)
end

function apply_classic_blue_style()
    reset_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 5.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.FrameRounding = 5.0
    style.ItemSpacing = imgui.ImVec2(10.0, 5.0)
    style.ScrollbarSize = 12.0
    style.ScrollbarRounding = 6.0
    style.GrabMinSize = 7.0
    style.GrabRounding = 3.0

    colors[clr.FrameBg] = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered] = ImVec4(0.26, 0.59, 0.98, 0.45)
    colors[clr.FrameBgActive] = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg] = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive] = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.Button] = ImVec4(0.16, 0.29, 0.48, 0.6)
    colors[clr.ButtonHovered] = ImVec4(0.26, 0.59, 0.98, 0.8)
    colors[clr.ButtonActive] = ImVec4(0.26, 0.59, 0.98, 1.0)
    colors[clr.Text] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.95)

    colors[clr.Header] = ImVec4(0.16, 0.29, 0.48, 0.6)
    colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.8)
    colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.0)

    colors[clr.SliderGrab] = ImVec4(0.16, 0.29, 0.48, 0.6)
    colors[clr.SliderGrabActive] = ImVec4(0.26, 0.59, 0.98, 0.8)
end

--
--     _   _   _ _____ ___  _   _ ____  ____    _  _____ _____   ______   __   ___  ____  _     _  __
--    / \ | | | |_   _/ _ \| | | |  _ \|  _ \  / \|_   _| ____| | __ ) \ / /  / _ \|  _ \| |   | |/ /
--   / _ \| | | | | || | | | | | | |_) | | | |/ _ \ | | |  _|   |  _ \\ V /  | | | | |_) | |   | ' /
--  / ___ \ |_| | | || |_| | |_| |  __/| |_| / ___ \| | | |___  | |_) || |   | |_| |  _ <| |___| . \
-- /_/   \_\___/  |_| \___/ \___/|_|   |____/_/   \_\_| |_____| |____/ |_|    \__\_\_| \_\_____|_|\_\                                                                                                                                                                                                                
--
-- Author: http://qrlk.me/samp
--
function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = getWorkingDirectory() .. '\\'..thisScript().name..'media-list.json'
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
      function(id, status, p1, p2)
        if status == dlstatus.STATUSEX_ENDDOWNLOAD then
          if doesFileExist(json) then
            local f = io.open(json, 'r')
            if f then
              local info = decodeJson(f:read('*a'))
              updatelink = info.updateurl
              updateversion = info.latest
              f:close()
              os.remove(json)
              if updateversion ~= thisScript().version then
                lua_thread.create(function(prefix)
                  local dlstatus = require('moonloader').download_status
                  local color = -1
                  sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                  wait(250)
                  downloadUrlToFile(updatelink, thisScript().path,
                    function(id3, status1, p13, p23)
                      if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                        print(string.format('Загружено %d из %d.', p13, p23))
                      elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        print('Загрузка обновления завершена.')
                        sampAddChatMessage((prefix..'Обновление завершено!'), color)
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) thisScript():reload() end)
                      end
                      if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                          sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                          update = false
                        end
                      end
                    end
                  )
                  end, prefix
                )
              else
                update = false
                print('v'..thisScript().version..': Обновление не требуется.')
              end
            end
          else
            print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
            update = false
          end
        end
      end
    )
    while update ~= false do wait(100) end
  end