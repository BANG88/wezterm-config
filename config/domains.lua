local platform = require('utils.platform')
local win_user = (os.getenv('USERNAME') or 'user'):lower()
local wsl_home = '/home/' .. win_user

local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ---@type SshDomain[]
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   ---@type UnixDomain[]
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   ---@type WslDomain[]
   wsl_domains = {},
}

if platform.is_win then
   options.default_domain = 'wsl:arch'

   options.ssh_domains = {
      {
         name = 'ssh:wsl',
         username = win_user,
         remote_address = 'localhost',
         multiplexing = 'None',
         default_prog = { 'fish', '-l' },
         assume_shell = 'Posix',
      },
   }

   options.wsl_domains = {
      {
         name = 'wsl:arch',
         distribution = 'archlinux',
         username = win_user,
         default_cwd = wsl_home,
      },
      {
         name = 'wsl:ubuntu-fish',
         distribution = 'Ubuntu',
         username = win_user,
         default_cwd = wsl_home,
         default_prog = { 'fish', '-l' },
      },
      {
         name = 'wsl:ubuntu-bash',
         distribution = 'Ubuntu',
         username = win_user,
         default_cwd = wsl_home,
         default_prog = { 'bash', '-l' },
      },
   }
end

return options
