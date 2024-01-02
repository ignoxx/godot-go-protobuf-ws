package server

type Config struct {
	addr string
}

func NewConfig() *Config {
	return &Config{
		addr: ":3000",
	}
}

func (c *Config) WithAddr(addr string) *Config {
	c.addr = addr
	return c
}
