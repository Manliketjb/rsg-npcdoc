Config = Config or {}

Config.Blip = {
    blipName = 'Doctor',
    blipSprite = 'blip_shop_doctor',
    blipScale = 0.2
}

Config.Target = false
Config.Debug = false

Config.Ped = 'U_M_M_RHDDOCTOR_01'
Config.OnlyDead = false
Config.JobDutyCheck = false
Config.MinMedics = 2
Config.ProgressTime = 5000

Config.Locations = {
    {
        name = 'Valentine Doctor', 
        coords = vector4(-286.61, 806.65, 119.39, 96.45),
        usePed = false,
        showblip = true,
    },
    {
        name = 'Strawberry Doctor', 
        coords = vector4(-1804.34, -430.1, 158.83, 75.68),
        usePed = false,
        showblip = true,
    },
    {
        name = 'Rhodes Doctor', 
        coords = vector4(1369.39, -1310.4, 77.94, 334.45),
        usePed = false,
        showblip = true,
    },
    {
        name = 'St Denis Doctor',  
        coords = vector4(2726.57, -1231.71, 50.37, 71.88),
        usePed = false,
        showblip = true,
    },
}
