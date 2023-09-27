package com.codecool.bytebattlers;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ByteBattlersApplication {

	private static final Logger logger = LoggerFactory.getLogger(ByteBattlersApplication.class);


	public static void main(String[] args) {
			SpringApplication.run(ByteBattlersApplication.class, args);
	}
}
