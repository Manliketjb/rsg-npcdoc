Config = Config or {}

Config.Blip = {
    blipName = 'Doctor',
    blipSprite = 'blip_shop_doctor',
    blipScale = 0.2
}

Config.Ped = 'U_M_M_RHDDOCTOR_01'
Config.OnlyDead = false
Config.JobDutyCheck = false
Config.MinMedics = 2
Config.ProgressTime = 5000

Config.Locations = {
    {
        name = 'Valentine Doctor', 
        prompt = 'valdoc', 
        coords = vector4(-362.35, 721.42, 116.38, 28.4),
        usePed = true,
        showblip = true
    },
}
