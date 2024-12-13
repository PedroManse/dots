#input PWD
#input service_name
#set ServiceName service_name [UpperCaseFirst()]
#filename {PWD}/service.ts
#done
import {{ Injectable, HttpException, HttpStatus }} from '@nestjs/common';
import {{ pbkdf2Sync }} from "node:crypto";
//import {{ PrismaService }} from "../../util/prisma";

@Injectable()
export class {ServiceName}Service {{
	constructor(
		private readonly prisma: PrismaService,
	) {{}}

	async remove(id: string) {{
		return `This action removes the user #${{id}}`;
	}}
}}

